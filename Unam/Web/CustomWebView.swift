//
//  CustomWebView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import WebKit
import Kanna

final class CustomWebView: WKWebView, WKNavigationDelegate {

    override init(frame: CGRect, configuration: WKWebViewConfiguration?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100), configuration: configuration ?? WKWebViewConfiguration())
        
        self.navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if navigationResponse.response is HTTPURLResponse {

        }
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func openPageWithSession(url: URL) {

        self.getCookies(for: "www.dgae-siae.unam.mx", completion: { (cookies) in
    
            let cookieHeader = (cookies.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: ";")
            
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Cookie": cookieHeader]
            let session = URLSession(configuration: config)
            
            var request = URLRequest(url: url)
            
            request.addValue(cookieHeader, forHTTPHeaderField: "Cookie")
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                   
                    DispatchQueue.main.async {
                        let webView = CustomWebView(frame: CGRect(x: 0, y: 0, width: 200, height: 550), configuration: nil)
                        webView.load(request)
                        UIApplication.shared.windows.first?.addSubview(webView)
                    }
                  
                }
            }
            
            task.resume()
        })
        
        
        
    }
}
