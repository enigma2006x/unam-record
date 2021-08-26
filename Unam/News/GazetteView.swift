//
//  GazetteView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 25/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Combine
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

final class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

final class WebViewModel: ObservableObject {
    
    let webView: WKWebView
    
    private let navigationDelegate: WebViewNavigationDelegate
    private var cancellable = Set<AnyCancellable>()
    private let urlString: String = Constant.Web.gazetteURL
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false

    init() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        webView = WKWebView(frame: .zero, configuration: configuration)
        navigationDelegate = WebViewNavigationDelegate()
        
        webView.navigationDelegate = navigationDelegate
        setupBindings()
        loadUrl()
    }
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack).sink(receiveValue: { (value) in
            self.canGoBack = value
        }).store(in: &cancellable)
        
        webView.publisher(for: \.canGoForward).sink(receiveValue: { (value) in
            self.canGoForward = value
        }).store(in: &cancellable)
        
        
        webView.publisher(for: \.isLoading).sink(receiveValue: { (value) in
            self.isLoading = value
        }).store(in: &cancellable)
        
    }
    
    private func loadUrl() {
        guard let url = URL(string: urlString) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
}


struct ContentView: View {
    
    @ObservedObject var model = WebViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                WebView(webView: model.webView)
            }
            
            ZStack{
                HStack {
                    Spacer()
                    Button(action: {
                        model.goBack()
                    }, label: {
                        Image(uiImage: UIImage(named: "leftArrow")!.withRenderingMode(.alwaysTemplate))
                    })
                    .frame(width: 60, height: 60, alignment: .center)
                    .disabled(!model.canGoBack)
                    
                    Button(action: {
                        model.goForward()
                    }, label: {
                        Image(uiImage: UIImage(named: "rightArrow")!.withRenderingMode(.alwaysTemplate))
                    })
                    .frame(width: 60, height: 60, alignment: .center)
                    .disabled(!model.canGoForward)
                    Spacer()
                }
                .padding(Constant.Measurement.base)
                .accentColor(Color(UIColor.customGold))
            }
        }
    }
}

