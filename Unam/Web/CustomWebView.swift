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

final class CustomWebview: WKWebView, WKScriptMessageHandler {
    
    func addResponse(contentController: WKUserContentController) {
        contentController.add(self, name: "nativeCallbackHandler")
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("\(message.body)")
        if message.name == "" {
            if let body = message.body as? String {
                userId = body
            }
        }
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    @ObservedObject var networkManager: NetworkManager
    
    let webView: CustomWebview =  {
        let contentController = WKUserContentController()
        
        let scriptSource = """
            $(document).ready(function() {
              $( "form" ).submit(function( event ) {
                document.body.style.backgroundColor = `red`;
                var value = $("input[name=usr_logi]").val();
                window.webkit.messageHandlers.nativeCallbackHandler.postMessage(value);
               // event.preventDefault();
              });
            });
        """;
        
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        //webView.configuration = config
        let webview = CustomWebview(frame: .zero, configuration: config)
        webview.addResponse(contentController: contentController)
        return webview
    }()
    
    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        
        
        
        if let url = URL(string: "https://www.dgae-siae.unam.mx/www_gate.php") {
            self.webView.load(URLRequest(url: url))
        }
        
        
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
    }
    
    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(viewModel: viewModel, networkManager: networkManager)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        private var networkManager: NetworkManager
        
        var load2 = false
        var htmlContains = false
        var htmlAcademicLog: String?
        
        init(viewModel: WebViewModel, networkManager: NetworkManager) {
            self.viewModel = viewModel
            self.networkManager = networkManager
            
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                for record in records {
                    //   print(record.displayName)
                    if record.displayName.contains(cookieName) {
                        dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                            print("Deleted: " + record.displayName);
                        })
                    }
                }
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if let response = navigationResponse.response as? HTTPURLResponse {
                let headers = response.allHeaderFields
                print(headers)
                
                if !self.load2 && self.htmlContains {
                    self.load2 = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let url = URL(string: "https://www.dgae-siae.unam.mx/www_try.php?cta=" + userId + "&llave=110%2C1194%2CL%2CE%2C11%2CP%2C202%2C68%2C11%2CFACULTAD+DE+INGENIERIA&acc=hsa")!
                        webView.load(URLRequest(url: url))
                        
                    }
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                       completionHandler: { (html: Any?, error: Error?) in
                                        
                                        if let mainHtml = html as? String, let doc = try? HTML(html: mainHtml, encoding: .utf8) {
                                            print(mainHtml)
                                            let account = doc.css("input[name='cta']")
                                            print("account12345")
                                            print(account)
                                        }
                                        
                                        if !self.htmlContains {
                                            let dataStore = WKWebsiteDataStore.default()
                                            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                                                self.htmlContains = records.contains { (record) -> Bool in
                                                    if record.displayName.contains(cookieName) {
                                                        //if let mainHtml =  html as? String {
                                                        
                                                        return true
                                                    }
                                                    return false
                                                }
                                            }
                                        } else if self.load2 && self.htmlContains {
                                            self.htmlAcademicLog = html as? String
                                            if let htmlAcademicLog = self.htmlAcademicLog, let doc = try? HTML(html: htmlAcademicLog, encoding: .utf8) {
                                                //print(htmlAcademicLog)
                                               // var subjects: [Subject] = []
                                                var countSection = 0
                                                var countRow = 0
                                                var sections: [SubjectSection] = []
                                                var section: SubjectSection = SubjectSection(id: countSection, title: "", results: [])
                                                for table in doc.css("table[cellpadding='1']") {
                                                    //  print(table.innerHTML)
                                                    for (indexTr, tr) in table.css("tr").enumerated() {
                                                        if indexTr == 0 {
                                                            continue
                                                        }
                                                        let td = tr.css("td")
                                                        
                                                        if td.count == 1 {
                                                            if section.results.count > 0 {
                                                                sections.append(section)
                                                            }
                                                            section = SubjectSection(id: countSection, title: td.first?.text, results: [])
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
                                                    if sections.count > 0 {
                                                        self.networkManager.subjectSections = sections
                                                    }
                                                }
                                                
                                                //                                            // Search for nodes by CSS
                                                //                                            for link in doc.css("a, link") {
                                                //                                                print(link.text)
                                                //                                                print(link["href"])
                                                //                                            }
                                                //
                                                //                                            // Search for nodes by XPath
                                                //                                            for link in doc.xpath("//a | //link") {
                                                //                                                print(link.text)
                                                //                                                print(link["href"])
                                                //                                            }
                                            }
                                        }
                                        
            })
            self.viewModel.didFinishLoading = true
        }
    }
}

struct SwiftUIWebView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIWebView(viewModel: WebViewModel(link: "https://google.com"), networkManager: NetworkManager())
    }
}
