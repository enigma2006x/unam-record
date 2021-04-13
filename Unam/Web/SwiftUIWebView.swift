//
//  CustomWebView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import WebKit
import Kanna

struct SwiftUIWebView: UIViewRepresentable {
    
    @ObservedObject private var networkManager: NetworkManager
    private var mainURL: URL?
    
    static let customWebView = CustomWebView(frame: .zero)
    static var pdfFile: String?
    
    init(networkManager: NetworkManager,
         mainURL: URL?) {
        self.networkManager = networkManager
        self.mainURL = mainURL
    }
    
    private let webView: CustomWebView =  {
        return customWebView
    }()
    
    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        
        if let url = mainURL {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
    }
    
    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        return Coordinator(networkManager: networkManager)
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        private var networkManager: NetworkManager
        var htmlAcademicLog: String?
        var allHeaderFields: [String: String] = [:]
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        
        init(networkManager: NetworkManager) {
            self.networkManager = networkManager
            self.networkManager.subjectSections = []
            self.networkManager.isShowingSubjectItems = false
            
            super.init()
        }
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationResponse: WKNavigationResponse,
                     decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            if navigationResponse.response is HTTPURLResponse {
                
                if !NetworkManager.isLoadAcademicTrajectory && NetworkManager.htmlContains {
                    NetworkManager.isLoadAcademicTrajectory = true
                    
                    if let url = URL(string: "https://www.dgae-siae.unam.mx/reg_try.html") {
                        webView.alpha = 0
                        webView.load(URLRequest(url: url))
                    }
                    
                }
            }
            decisionHandler(.allow)
        }
        
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                       completionHandler: { (html: Any?, error: Error?) in
                                        
                                        if let htmlString = html as? String,
                                           let doc = try? HTML(html: htmlString, encoding: .utf8) {
                                            
                                            let accountInput = doc.css("input[type='hidden']", namespaces: ["name": "cta"])
                                            if let accountTag = accountInput.first,
                                               let accountValue = accountTag["value"],
                                               !accountValue.isEmpty && accountValue != "aut" {
                                                webView.alpha = 0
                                                self.networkManager.accountID = accountValue.trimmingCharacters(in: .whitespacesAndNewlines)
                                            }
                                            
                                            let imageInput = doc.css("img[class='foto_alumno']")
                                            
                                            if let imageTag = imageInput.first,
                                               let imageValue = imageTag["src"],
                                               !imageValue.isEmpty,
                                               let image = imageValue.base64ToImage() {
                                                self.networkManager.accountImage = image
                                            }
                                            
                                            let tableInput = doc.css("table td[class='CellDat']").dropFirst()
                                            if let tableTag = tableInput.makeIterator().next(),
                                               let tableValue = tableTag.text,
                                               !tableValue.isEmpty {
                                                self.networkManager.accountFullName = tableValue.trimmingCharacters(in: .whitespacesAndNewlines)
                                            }
                                        }
                                        
                                        if !NetworkManager.htmlContains {
                                            let dataStore = WKWebsiteDataStore.default()
                                            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                                                NetworkManager.htmlContains = records.contains { (record) -> Bool in
                                                    if record.displayName.contains(NetworkManager.cookieName) {
                                                        return true
                                                    }
                                                    return false
                                                }
                                            }
                                            
                                        } else if NetworkManager.isLoadAcademicTrajectory && NetworkManager.htmlContains &&
                                                    !NetworkManager.isLoadAcademicContent {
                                            
                                            if let htmlString = html as? String, htmlString.contains("captcha") {
                                                webView.alpha = 1
                                                NetworkManager.isLoadAcademicTrajectory = false
                                                return
                                            }
                                            
                                            let formAcademicLog = html as? String
                                            if let htmlAcademicLog = formAcademicLog,
                                               let doc = try? HTML(html: htmlAcademicLog, encoding: .utf8) {
                                                
                                                let tables = doc.css("table tr",
                                                                     namespaces: ["width": "100%", "class": "TblBlk"])
                                                
                                                tables.enumerated().forEach({ index, item in
                                                    guard let radioInput = item.css("input[type='radio']",
                                                                                    namespaces: ["name": "llave"]).first,
                                                          let keyValue = radioInput["value"],
                                                          let campusTag = item.css("span",
                                                                                   namespaces: ["class": "TitNfo"]).first,
                                                          let campusValue = campusTag["title"]
                                                    
                                                    else {
                                                        return
                                                    }
                                                    
                                                    let tdTags = item.css("td[class='CellDat']")
                                                    
                                                    if tdTags.count > 7,
                                                       let planNameValue = tdTags[4].text, planNameValue.count > 5 {
                                                        
                                                        let academicItem = AcademicItem(id: index,
                                                                                        key: keyValue,
                                                                                        campus: campusValue,
                                                                                        planName: planNameValue)
                                                        
                                                        if !self.networkManager.academicItems.contains(academicItem) {
                                                            self.networkManager.academicItems.append(academicItem)
                                                        }
                                                    }
                                                })
                                                
                                                if !self.networkManager.accountID.isEmpty &&
                                                    !self.networkManager.accountFullName.isEmpty {
                                                    
                                                    self.networkManager.isShowingAcademicItems = true
                                                    webView.alpha = 0
                                                    NetworkManager.isLoadAcademicContent = true
                                                }
                                                
                                            }
                                            
                                        } else if NetworkManager.isLoadAcademicContent && NetworkManager.htmlContains {
                                            self.htmlAcademicLog = html as? String
                                            if let htmlAcademicLog = self.htmlAcademicLog,
                                               let doc = try? HTML(html: htmlAcademicLog, encoding: .utf8) {
                                                
                                                let path = self.createPDF(formatter: webView.viewPrintFormatter(),
                                                                          filename: "PDFDocument")
                                                SwiftUIWebView.pdfFile = path
                                                var countSection = 0
                                                var countRow = 0
                                                var sections: [SubjectSection] = []
                                                var section: SubjectSection = SubjectSection(id: countSection,
                                                                                             title: "",
                                                                                             results: [])
                                                
                                                for table in doc.css("table[cellpadding='1']") {
                                                    
                                                    for (indexTr, tr) in table.css("tr").enumerated() {
                                                        if indexTr == 0 {
                                                            continue
                                                        }
                                                        let td = tr.css("td")
                                                        
                                                        if td.count == 1 {
                                                            if section.results.count > 0 {
                                                                sections.append(section)
                                                            }
                                                            section = SubjectSection(id: countSection,
                                                                                     title: td.first?.text ?? "",
                                                                                     results: [])
                                                            countSection += 1
                                                            
                                                            continue
                                                        }
                                                        var subject = Subject(id: countRow)
                                                        countRow += 1
                                                        for (indexTd, td) in td.enumerated() {
                                                            
                                                            if indexTd == 0 {
                                                                subject.idPlantel = td.text
                                                            } else if indexTd == 1 {
                                                                subject.idSubject = td.text
                                                            } else if indexTd == 2 {
                                                                subject.credits = td.text
                                                            } else if indexTd == 3 {
                                                                subject.type = td.text
                                                            } else if indexTd == 4 {
                                                                subject.name = td.text?.lowercased().capitalized
                                                            } else if indexTd == 5 {
                                                                subject.qualification = td.text
                                                            } else if indexTd == 6 {
                                                                subject.examType = td.text
                                                            } else if indexTd == 7 {
                                                                subject.period = td.text
                                                            } else if indexTd == 8 {
                                                                subject.folio = td.text
                                                            } else if indexTd == 9 {
                                                                subject.group = td.text
                                                            } else if indexTd == 10 {
                                                                subject.ord = td.text
                                                            } else if indexTd == 11 {
                                                                subject.ext = td.text
                                                            }
                                                        }
                                                        
                                                        section.results.append(subject)
                                                        
                                                    }
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    self.networkManager.subjectSections = sections
                                                    self.networkManager.isShowingSubjectItems = true
                                                }
                                            }
                                        }
                                        
                                       })
        }
        
        private func createPDF(formatter: UIViewPrintFormatter, filename: String) -> String {
           
            // 2. Assign print formatter to UIPrintPageRenderer
            let render = UIPrintPageRenderer()
            render.addPrintFormatter(formatter, startingAtPageAt: 0)
            
            // 3. Assign paperRect and printableRect
            let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
            let printable = page.insetBy(dx: 0, dy: 0)
            
            render.setValue(NSValue(cgRect: page), forKey: "paperRect")
            render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
            
            // 4. Create PDF context and draw
            let pdfData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
            
            for i in 1...render.numberOfPages {
                
                UIGraphicsBeginPDFPage();
                let bounds = UIGraphicsGetPDFContextBounds()
                render.drawPage(at: i - 1, in: bounds)
            }
            
            UIGraphicsEndPDFContext()
            
            // 5. Save PDF file
            let path = "\(NSTemporaryDirectory())\(filename).pdf"
            pdfData.write(toFile: path, atomically: true)
    
            return path
        }
    }
}

struct SwiftUIWebView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIWebView(networkManager: NetworkManager.shared, mainURL: URL(string: ""))
    }
}
