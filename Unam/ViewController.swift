////
////  ViewController.swift
////  Unam
////
////  Created by Jose Antonio Trejo Flores on 18/02/20.
////  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
////
//
//import UIKit
//import WebKit
//import Kanna
//
//class ViewController: UIViewController {
//    
//    var webView: WKWebView!
//    
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        
//        view = webView
//        //view.addSubview(webView)
//    }
//    
////    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
//////        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//////        webView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
////        webView = WKWebView(frame: CGRect(origin: CGPoint.zero, size: videoContainer.frame.size))
////
////        webView.addSubview(videoWebKitView)
////    }
////
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 1
//        let url = URL(string: "https://www.dgae-siae.unam.mx/www_gate.php")!
//        webView.load(URLRequest(url: url))
//        
//        // 2
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
//        toolbarItems = [refresh]
//        navigationController?.isToolbarHidden = false
//        
//    }
//    
//    
//    
//    func userContentController(userContentController: WKUserContentController,
//                               didReceiveScriptMessage message: WKScriptMessage) {
//        
//        if message.name == "didGetHTML" {
//            if let html = message.body as? String {
//                print(html)
//            }
//        }
//    }
//    
//    var load2 = false
//    var htmlContains = false
//    var htmlAcademicLog: String?
//}
//
//extension ViewController: WKNavigationDelegate {
//    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        title = webView.title
//        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
//                                   completionHandler: { (html: Any?, error: Error?) in
//                                  
//                                    if let html = html as? String, html.contains("Bienvenido al SIAE") {
//                                        self.htmlContains = true
//                                          print(html)
//                                    } else if self.load2 && self.htmlContains {
//                                        self.htmlAcademicLog = html as? String
//                                        if let htmlAcademicLog = self.htmlAcademicLog, let doc = try? HTML(html: htmlAcademicLog, encoding: .utf8) {
//                                            print(htmlAcademicLog)
//                                            var subjects: [Subject] = []
//                                            for table in doc.css("table[cellpadding='1']") {
//                                              //  print(table.innerHTML)
//                                                for (indexTr, tr) in table.css("tr").enumerated() {
//                                                    if indexTr == 0 {
//                                                        continue
//                                                    }
//                                                    let td = tr.css("td")
//                                                    if td.count == 1 {
//                                                        print(td.first?.text)
//                                                        continue
//                                                    }
//                                                    var subject = Subject()
//                                                    for (indexTd, td) in td.enumerated() {
//                                                       
//                                                        if indexTd == 0 {
//                                                            subject.idPlantel = td.text
//                                                        } else if indexTd == 1 {
//                                                            subject.idSubject = td.text
//                                                        } else if indexTd == 2 {
//                                                            subject.credits = td.text
//                                                        } else if indexTd == 3 {
//                                                            subject.name = td.text
//                                                        } else if indexTd == 4 {
//                                                            subject.qualification = td.text
//                                                        } else if indexTd == 5 {
//                                                            subject.examType = td.text
//                                                        } else if indexTd == 6 {
//                                                            subject.period = td.text
//                                                        } else if indexTd == 7 {
//                                                            subject.folio = td.text
//                                                        } else if indexTd == 8 {
//                                                            subject.group = td.text
//                                                        } else if indexTd == 9 {
//                                                            subject.ord = td.text
//                                                        } else if indexTd == 10 {
//                                                            subject.ext = td.text
//                                                        }
//                                                        
//                                                    }
//                                                    subjects.append(subject)
//                                                }
//                                            }
//                                            print(subjects)
//                                            
////                                            // Search for nodes by CSS
////                                            for link in doc.css("a, link") {
////                                                print(link.text)
////                                                print(link["href"])
////                                            }
////
////                                            // Search for nodes by XPath
////                                            for link in doc.xpath("//a | //link") {
////                                                print(link.text)
////                                                print(link["href"])
////                                            }
//                                        }
//                                    }
//                                    
//        })
//    }
//    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        if let response = navigationResponse.response as? HTTPURLResponse {
//            let headers = response.allHeaderFields
//            print(headers)
//            
//            let dataStore = WKWebsiteDataStore.default()
//            dataStore.httpCookieStore.getAllCookies({ (cookies) in
//                if !cookies.isEmpty && !self.load2 && self.htmlContains {
//                    self.load2 = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        print(cookies)
//                        
//                        let url = URL(string: "https://www.dgae-siae.unam.mx/www_try.php?cta=099321956&llave=110%2C1194%2CL%2CE%2C11%2CP%2C202%2C68%2C11%2CFACULTAD+DE+INGENIERIA&acc=hsa")!
//                        self.webView.load(URLRequest(url: url))
//                        
//                    }
//                }
//            })
//        }
//        decisionHandler(.allow)
//    }
//}
//
