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

//let group = DispatchGroup()          //create a group for a bunch of tasks we are about to do
//   for i in 0...3 {                     //launch a bunch of tasks (eg a bunch of webservice calls that all need to be finished before proceeding to the next ViewController)
//       group.enter()                    //let the group know that something is being added
//       DispatchQueue.global().async {   //run tasks on a background thread
//           sleep(arc4random() % 4)      //do some long task eg webservice or database lookup (here we are just sleeping for a random amount of time for demonstration purposes)
//           print("long task \(i) done!")
//           group.leave()                //let group know that the task is finished
//       }
//   }
//   group.wait()                         //will block whatever thread we are on here until all the above tasks have finished (so maybe dont use this function on your main thread)
//   print("all tasks done!")
class CallbackWebView: WKWebView, WKNavigationDelegate {
    
    var finish: ((Bool) -> Void)?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100), configuration: configuration ?? WKWebViewConfiguration())
        
        // UIApplication.shared.windows.first?.addSubview(self)
        //        self.navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        self.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                completionHandler: { (html: Any?, error: Error?) in
                                    
                                    if let mainHtml = html as? String, let doc = try? HTML(html: mainHtml, encoding: .utf8) {
                                        print(self.url)
                                        print(mainHtml)
                                        self.finish?(true)
                                    }
        })
    }
}

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
    
    let webView: CallbackWebView =  {
        let contentController = WKUserContentController()
        
        let scriptSource = """
            $(document).ready(function() {
              $( "form" ).submit(function( event ) {
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
        let webview = CallbackWebView(frame: .zero, configuration: config)
        //      webview.addResponse(contentController: contentController)
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
                            print("Deleted: " + record.displayName)
                            
                        })
                    }
                }
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            
        }
        
        var allHeaderFields: [String : String] = [:]
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            if let response = navigationResponse.response as? HTTPURLResponse {
                //let headers = response.allHeaderFields
                //if let headerFields = headers as? [AnyHashable : String] {
                //  allHeaderFields = headerFields
                //}
                //                for header in headers.enumerated() {
                //                    print(header)
                //                    if let key = header.element.value as? String, let value = headers[key] as? String {
                //                        allHeaderFields[key] = value
                //                    }
                //                    //allHeaderFields
                //                }
                //
                //                print(allHeaderFields)
                
                if !self.load2 && self.htmlContains {
                    webView.alpha = 0
                    self.load2 = true
                    // DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let url = URL(string: "https://www.dgae-siae.unam.mx/www_try.php?cta=" + userId + "&llave=110%2C1194%2CL%2CE%2C11%2CP%2C202%2C68%2C11%2CFACULTAD+DE+INGENIERIA&acc=hsa")!
                    webView.load(URLRequest(url: url))
                    
                    //  }
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                       completionHandler: { (html: Any?, error: Error?) in
                                        
                                        if let mainHtml = html as? String, let doc = try? HTML(html: mainHtml, encoding: .utf8) {
                                            print(mainHtml)
                                            //let account = doc.css("input[name='cta']")
                                            //print("account12345")
                                            //print(account)
                                            let frames = doc.css("frame")
                                            var wait = 5
                                            for frame in frames {
                                                
                                                guard let src = frame["src"] else { return }
                                                // self.group.enter()
                                                
                                                //                                                var session = URLSession.shared
                                                //                                                if  let cookies =  URLSession.shared.configuration.httpCookieStorage?.cookies {
                                                //                                                    URLSession.shared.configuration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: url)
                                                //                                                }
                                                //
                                                //                                                let dataStore = WKWebsiteDataStore.default()
                                                //                                                dataStore.httpCookieStore.getAllCookies { (cookies) in
                                                //
                                                //                                                    print(src)
                                                //                                                    let url = URL(string: "https://www.dgae-siae.unam.mx/\(src)")!
                                                //                                                    print(url)
                                                //                                                    var request = URLRequest(url: url)
                                                //
                                                //                                                    //request.httpShouldHandleCookies = true
                                                //                                                    self.allHeaderFields["Upgrade-Insecure-Requests"] = "1"
                                                //                                                    request.allHTTPHeaderFields = self.allHeaderFields
                                                //
                                                //                                                    print(cookies)
                                                //                                                    URLSession.shared.configuration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: url)
                                                //                                                    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                                                //                                                        guard let data = data else { return }
                                                //                                                        let html = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
                                                //
                                                //
                                                //                                                        print(html)
                                                //
                                                //                                                    }
                                                //
                                                //                                                    task.resume()
                                                //                                                }
                                                
                                                //WKWebViewConfiguration.cookiesIncluded { [weak self] configuration in
                                                
                                                //}
                                                
                                                //                         DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                                //                                                    let url = URL(string: "https://www.dgae-siae.unam.mx/\(src)")!
                                                //                                                    self.semaphore.wait()
                                                //                                                    // CallbackWebView(frame: .zero, url: url, configuration: configuration)
                                                //                                                    webView.load(URLRequest(url: url))
                                                //
                                                //                                                    if let callbackWebView = webView as? CallbackWebView {
                                                //
                                                //                                                        callbackWebView.finish = { (status) in
                                                //                                                            //self.group.leave()
                                                //                                                            self.semaphore.signal()
                                                //                                                        }
                                                //                                                    }
                                                //            }
                                                
                                                wait += 5
                                                //webview2.load(URLRequest(url: url))
                                                
                                                
                                            }
                                            //group.wait()
                                            //                                            self.group.notify(queue: .main) {
                                            //                                                print("finish")
                                            //                                            }
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
                                                        self.networkManager.showSubjectList = true
                                                    }
                                                }
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

//extension WKWebViewConfiguration {
//    /// Async Factory method to acquire WKWebViewConfigurations packaged with system cookies
//    static func cookiesIncluded(completion: @escaping (WKWebViewConfiguration?) -> Void) {
//        let config = WKWebViewConfiguration()
//        guard let cookies = HTTPCookieStorage.shared.cookies else {
//            completion(config)
//            return
//        }
//        // Use nonPersistent() or default() depending on if you want cookies persisted to disk
//        // and shared between WKWebViews of the same app (default), or not persisted and not shared
//        // across WKWebViews in the same app.
//        let dataStore = WKWebsiteDataStore.nonPersistent()
//        let waitGroup = DispatchGroup()
//        for cookie in cookies {
//            waitGroup.enter()
//            dataStore.httpCookieStore.setCookie(cookie) { waitGroup.leave() }
//        }
//        waitGroup.notify(queue: DispatchQueue.main) {
//            config.websiteDataStore = dataStore
//            completion(config)
//        }
//    }
//}
