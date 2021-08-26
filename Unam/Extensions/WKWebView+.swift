//
//  WKWebView+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import WebKit

extension WKWebView {
    
    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }
    
    func getCookies(for domain: String? = nil,
                    key: String = "Value",
                    completion: @escaping ([String: String])->())  {
        var cookieDict = [String : String]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                
                if let dict = cookie.properties as NSDictionary?, let value = dict[key] as? String {
                    
                    if let domain = domain {
                        if cookie.domain.contains(domain) {
                            cookieDict[cookie.name] = value
                        }
                    } else {
                        cookieDict[cookie.name] = value
                    }
                }
            }
            completion(cookieDict)
        }
    }
    
    func printContent() {
        
        if let path = UserDataWebModel.pdfFile {
            let url = URL(fileURLWithPath: path)
            UserDataWebModel.customWebView.load(URLRequest(url: url))
        }
        
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printInfo.jobName = Constant.SubjectDetail.title
        printInfo.duplex = .none
        printInfo.orientation = .portrait
        
        printController.printPageRenderer = nil
        printController.printingItems = nil
        printController.printingItem = UserDataWebModel.customWebView.url
        
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = true
        
        printController.present(animated: true)
    }
    
    func shareContent() {
        guard let documentPath = UserDataWebModel.pdfFile,
              FileManager.default.fileExists(atPath: documentPath) else { return }
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [NSURL(fileURLWithPath: documentPath)], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
    }
}
