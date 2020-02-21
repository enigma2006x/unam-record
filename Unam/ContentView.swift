//
//  ContentView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 18/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import WebKit
import Kanna
import Combine

//var subjectItems: [Subject] = [Subject(id: 1), Subject(id: 2)]
//var subjectItems: [Subject] = []

struct SubjectList {
  var results: [Subject]
}

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        NavigationView {
            VStack {
                List(networkManager.subjectList.results) { subject in
                    SubjectRow(subject: subject)
                }
                SwiftUIWebView(viewModel: WebViewModel(link: "https://www.dgae-siae.unam.mx/www_gate.php"), networkManager: networkManager)
            }.navigationBarTitle(Text("WebPage"))
        }
    }
}

class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    
    init (link: String) {
        self.link = link
    }
}

class NetworkManager: ObservableObject {
    //var didChange = PassthroughSubject<NetworkManager, Never>()
    @Published var subjectList = SubjectList(results: [])
}

var cookieName = "unam"

struct SwiftUIWebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    @ObservedObject var networkManager: NetworkManager
    
    let webView = WKWebView()
    
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
                    print(record.displayName)
                    if record.displayName.contains(cookieName) {
                        dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                            print("Deleted: " + record.displayName);
                        })
                    }
                }
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if let response = navigationResponse.response as? HTTPURLResponse {
                let headers = response.allHeaderFields
                print(headers)
                
//                let dataStore = WKWebsiteDataStore.default()
//
//                dataStore.httpCookieStore.getAllCookies({ (cookies) in
//                    if !cookies.isEmpty && !self.load2 && self.htmlContains {
//                        self.load2 = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            print(cookies)
//
//                            let url = URL(string: "https://www.dgae-siae.unam.mx/www_try.php?cta=099321956&llave=110%2C1194%2CL%2CE%2C11%2CP%2C202%2C68%2C11%2CFACULTAD+DE+INGENIERIA&acc=hsa")!
//                            webView.load(URLRequest(url: url))
//
//                        }
//                    }
//                })
                
                if !self.load2 && self.htmlContains {
                    self.load2 = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let url = URL(string: "https://www.dgae-siae.unam.mx/www_try.php?cta=099321956&llave=110%2C1194%2CL%2CE%2C11%2CP%2C202%2C68%2C11%2CFACULTAD+DE+INGENIERIA&acc=hsa")!
                        webView.load(URLRequest(url: url))
                        
                    }
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                       completionHandler: { (html: Any?, error: Error?) in
                                        
                                        if !self.htmlContains {
                                            let dataStore = WKWebsiteDataStore.default()
                                            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                                                print(records)
                                                self.htmlContains = records.contains { (record) -> Bool in
                                                    if record.displayName.contains(cookieName) {
                                                        return true
                                                    }
                                                    return false
                                                }
                                            }
                                        } else if self.load2 && self.htmlContains {
                                            self.htmlAcademicLog = html as? String
                                            if let htmlAcademicLog = self.htmlAcademicLog, let doc = try? HTML(html: htmlAcademicLog, encoding: .utf8) {
                                                //print(htmlAcademicLog)
                                                var subjects: [Subject] = []
                                                var count = 0
                                                for table in doc.css("table[cellpadding='1']") {
                                                    //  print(table.innerHTML)
                                                    for (indexTr, tr) in table.css("tr").enumerated() {
                                                        if indexTr == 0 {
                                                            continue
                                                        }
                                                        let td = tr.css("td")
                                                        if td.count == 1 {
                                                            print(td.first?.text)
                                                            continue
                                                        }
                                                        var subject = Subject(id: count)
                                                        count += 1
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
                                                                subject.name = td.text
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
                                                        print(subject)
                                                         subjects.append(subject)
                                                       
                                                        
                                                    }
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    if subjects.count > 0 {
                                                        self.networkManager.subjectList.results = subjects
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SubjectRow: View {
    var subject: Subject
    var body: some View {
        HStack {
            Text("\(subject.name ?? "") \(subject.qualification ?? "")")
            Spacer()
        }
    }
}

struct Subject: Identifiable {
    var id: Int
    var idPlantel: String?
    var idSubject: String?
    var credits: String?
    var qualification: String?
    var type: String?
    var name: String?
    var examType: String?
    var period: String?
    var folio: String?
    var group: String?
    var ord: String?
    var ext: String?
}
