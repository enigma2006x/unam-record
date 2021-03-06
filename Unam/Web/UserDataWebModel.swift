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

protocol UserDataWebModelDataSource {
    func getAcademicTrajectory() -> String
    func getAcademicRecord() -> String
}

struct UserDataWebModel: UIViewRepresentable {
    
    public static var dataSource: UserDataWebModelDataSource?
    
    @ObservedObject private var userDataViewModel: UserDataViewModel
    
    private var mainURL: URL?
    
    static let customWebView = CustomWebView(frame: .zero)
    static var pdfFile: String?
    
    init(userDataViewModel: UserDataViewModel,
         mainURL: URL?) {
        self.userDataViewModel = userDataViewModel
        self.mainURL = mainURL
    }
    
    private let webView: CustomWebView =  {
        customWebView.backgroundColor = .clear
        customWebView.isOpaque = false
        return customWebView
    }()
    
    func makeUIView(context: UIViewRepresentableContext<UserDataWebModel>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        
        if let url = mainURL {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<UserDataWebModel>) {
    }
    
    func makeCoordinator() -> UserDataWebModel.Coordinator {
        return Coordinator(userDataViewModel: userDataViewModel)
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        
        private var userDataViewModel: UserDataViewModel
       
        var allHeaderFields: [String: String] = [:]
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        
        init(userDataViewModel: UserDataViewModel) {
            self.userDataViewModel = userDataViewModel
            self.userDataViewModel.subjectSections = []
            self.userDataViewModel.isShowingSubjectItems = false
            
            super.init()
        }
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationResponse: WKNavigationResponse,
                     decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            if navigationResponse.response is HTTPURLResponse {
                
                if !UserDataViewModel.isLoadAcademicTrajectory && UserDataViewModel.htmlContains {
                    UserDataViewModel.isLoadAcademicTrajectory = true
                    
                    loadAcademicRecords(webView)
                    
                }
            }
            decisionHandler(.allow)
        }
        
        private func loadAcademicRecords(_ webView: WKWebView) {
            if let url = URL(string: Constant.Web.academicRecordsURL) {
                webView.alpha = 0
                webView.load(URLRequest(url: url))
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                       completionHandler: { [weak self] (html: Any?, error: Error?) in
                                        
                                        guard let self = self else { return }
                                      
                                       
                                        if Constant.isDebugMode {
                                            self.userDataViewModel.setTestAccount()
                            
                                        } else if let htmlString = html as? String,
                                           let doc = try? HTML(html: htmlString, encoding: .utf8),
                                           self.userDataViewModel.accountID.isEmpty {
                                            
                                            let accountInput = doc.css("input[type='hidden']", namespaces: ["name": "cta"])
                                            if let accountTag = accountInput.first,
                                               let accountValue = accountTag["value"],
                                               !accountValue.isEmpty && accountValue != "aut" {
                                                webView.alpha = 0
                                                self.userDataViewModel.accountID = accountValue.trimmingCharacters(in: .whitespacesAndNewlines)
                                            }
                                            
                                            let imageInput = doc.css("img[class='foto_alumno']")
                                            
                                            if let imageTag = imageInput.first,
                                               let imageValue = imageTag["src"],
                                               !imageValue.isEmpty,
                                               let image = imageValue.base64ToImage() {
                                                self.userDataViewModel.accountImage = image
                                            }
                                            
                                            let tableInput = doc.css("table td[class='CellDat']").dropFirst()
                                            if let tableTag = tableInput.makeIterator().next(),
                                               let tableValue = tableTag.text,
                                               !tableValue.isEmpty, Int(tableValue) == nil {
                                                self.userDataViewModel.accountFullName = tableValue.trimmingCharacters(in: .whitespacesAndNewlines)
                                            }
                                        }
                                        
                                        if !UserDataViewModel.htmlContains {
                                            let dataStore = WKWebsiteDataStore.default()
                                            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                                                UserDataViewModel.htmlContains = records.contains { (record) -> Bool in
                                                    if record.displayName.contains(UserDataViewModel.cookieName) {
                                                        return true
                                                    }
                                                    return false
                                                }
                                            }
                                            
                                        } else if UserDataViewModel.isLoadAcademicTrajectory && UserDataViewModel.htmlContains &&
                                                    !UserDataViewModel.isLoadAcademicContent {
                                            
                                            if let htmlString = html as? String, htmlString.contains("captcha"), !Constant.isDebugMode {
                                                webView.alpha = 1
                                                UserDataViewModel.isLoadAcademicTrajectory = false
                                                return
                                            }
                                            
                                            var formAcademicLog = html as? String
                                            
                                            if Constant.isDebugMode, let dataSource = UserDataWebModel.dataSource {
                                                formAcademicLog = dataSource.getAcademicTrajectory()
                                            }
                                            
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
                                                        
                                                        var campusIdValue = "-"
                                                        var careerIdValue = "-"
                                               
                                                        let campusId = tdTags[0].text
                                                        campusIdValue = campusId ?? "-"
                                                        
                                                        let careerId = tdTags[1].text
                                                        careerIdValue = careerId ?? "-"
                                                
                                                        careerIdValue = careerIdValue.isEmpty ? "-" : careerIdValue
                                                        
                                                        var academicItem = AcademicItem(id: index,
                                                                                        key: keyValue,
                                                                                        campus: campusValue.capitalized,
                                                                                        planName: planNameValue.capitalized)
                                                        academicItem.campusId = campusIdValue
                                                        academicItem.careerId = careerIdValue
                                                        
                                                        if !self.userDataViewModel.academicItems.contains(academicItem) {
                                                            self.userDataViewModel.academicItems.append(academicItem)
                                                        }
                                                    }
                                                    
                                                    
                                                })
                                                
                                                if !self.userDataViewModel.accountID.isEmpty &&
                                                    !self.userDataViewModel.accountFullName.isEmpty {
                                                    
                                                    self.userDataViewModel.isShowingAcademicItems = true
                                                    webView.alpha = 0
                                                    UserDataViewModel.isLoadAcademicContent = true
                                                }
                                                
                                            }
                                            
                                        } else if UserDataViewModel.isLoadAcademicContent && UserDataViewModel.htmlContains {
                                            
                                            var htmlAcademicLog = html as? String
                                            if Constant.isDebugMode, let dataSource = UserDataWebModel.dataSource {
                                              
                                                htmlAcademicLog = dataSource.getAcademicRecord()
                                            }
                                            
                                            
                                            if let htmlAcademicLog = htmlAcademicLog,
                                                let doc = try? HTML(html: htmlAcademicLog, encoding: .utf8) {
                                                
                                                let path = self.createPDF(formatter: webView.viewPrintFormatter(),
                                                                          filename: Constant.Pdf.title)
                                                UserDataWebModel.pdfFile = path
                                                var countSection = 0
                                                var countRow = 0
                                                var sections: [SubjectSection] = []
                                                var section: SubjectSection = SubjectSection(id: countSection,
                                                                                             title: "",
                                                                                             average: 0,
                                                                                             results: [])
                                                
                                                if let average = doc.css("td[class='CellTns']").first(where: { $0.text?.lowercased().contains("promedio") ?? false }), let averageValue = average.text?.lowercased().replacingOccurrences(of: "promedio", with: "")  {
                                                    
                                                    if Constant.isDebugMode {
                                                        section.average = 10
                                                    } else {
                                                        section.average = Double(averageValue) ?? 0
                                                    }
                                                }
                                                
                                                if doc.css("td[class='CellTns']").count > 24  {
                                                    if let totalPercentage = doc.css("td[class='CellTns']")[23].text?.replacingOccurrences(of: "%", with: "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
                                                        
                                                        if Constant.isDebugMode {
                                                            section.totalPercentage = 100
                                                        } else {
                                                            section.totalPercentage = Double(totalPercentage)
                                                        }
                                                        
                                                    }
                                                }
                                                
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
                                                                                     title: td.first?.text?.capitalized ?? "",
                                                                                     average: section.average,
                                                                                     results: [],
                                                                                     totalPercentage: section.totalPercentage)
                                                            countSection += 1
                                                            
                                                            continue
                                                        }
                                                        var subject = Subject(id: countRow)
                                                        countRow += 1
                                                        for (indexTd, td) in td.enumerated() {
                                                            
                                                            if indexTd == 0 {
                                                                subject.idCampus = td.text?.capitalized
                                                            } else if indexTd == 1 {
                                                                subject.idSubject = td.text
                                                            } else if indexTd == 2 {
                                                                subject.credits = td.text
                                                            } else if indexTd == 3 {
                                                                subject.type = td.text
                                                            } else if indexTd == 4 {
                                                                subject.name = td.text?.capitalized
                                                            } else if indexTd == 5 {
                                                                if Constant.isDebugMode {
                                                                    subject.qualification = "10"
                                                                } else {
                                                                    subject.qualification = td.text
                                                                }
                                                            } else if indexTd == 6 {
                                                                subject.examType = td.text
                                                            } else if indexTd == 7 {
                                                                subject.period = td.text
                                                            } else if indexTd == 8 {
                                                                subject.invoice = td.text
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
                                                    self.userDataViewModel.subjectSections = sections
                                                    self.userDataViewModel.isShowingSubjectItems = true
                                                }
                                            }
                                        }})
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

struct UserDataWebModel_Previews: PreviewProvider {
    static var previews: some View {
        UserDataWebModel(userDataViewModel: UserDataViewModel.shared, mainURL: URL(string: ""))
    }
}
