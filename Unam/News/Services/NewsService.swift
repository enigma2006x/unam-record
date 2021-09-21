//
//  NewsService.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 09/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Foundation
import Kanna

final class NewsService: ObservableObject {
    
    @Published var selectedItem: NewsItem?
    
    @Published var highlightedItems = [NewsItem]()
    
    @Published var items = [NewsItem]()
    
    @Published var minWidth: CGFloat = UIScreen.main.bounds.size.width
    
    private static let unacepptedWords = ["terror",
                                          "embarazo",
                                          "virus",
                                          "covid",
                                          "enfermedad",
                                          "19",
                                          "depre",
                                          "11",
                                          "guerra",
                                          "suicidios",
                                          "muerte",
                                          "horror",
                                          "pandemia",
                                          "guerra",
                                          "suceso",
                                          "suicidio",
                                          "suicidas",
                                          "confinamiento"]
    
    private func getNews(inContainer container: XMLElement) {
        
        for listing in container.css("div[class*='bs-listing']") {
            guard listing.css("p[class*='section-heading']").first != nil,
                  let category = listing.css("span[class*='h-text']").first?.text?.capitalized.clean else { continue }
            
            for item in listing.css("div[class*='item-inner']") {
                
                for link in item.css("a[class*='img-holder']") {
                    guard let title = link["title"]?.clean,
                          let url = link["href"],
                          let image = link["data-src"],
                          let summary = item.css("div[class*='post-summary']").first?.text?.clean
                    else { continue }
                    
                    if summary.lowercased().contains(NewsService.unacepptedWords) || title.lowercased().contains(NewsService.unacepptedWords) {
                        continue
                    }
                    
                    let item = NewsItem(title: title,
                                        url: url,
                                        image: image,
                                        summary: summary,
                                        category: category,
                                        subCategory: category)
                    
                    DispatchQueue.main.async {
                        if !self.items.contains(item) {
                            self.items.append(item)
                        }
                    }
                }
            }
        }
    }
    
    private func getHighlightedNews(inContainer container: XMLElement) {
        
        for category in container.css("h2[class*='vc_custom_heading']") {
            
            guard let categoryTitle = category.text?.clean.capitalized, categoryTitle == "Destacado" else {
                continue
            }
            
            for item in container.css("div[class*='item-inner']") {
                
                for link in item.css("a[class*='img-holder']") {
                    guard let title = link["title"]?.clean,
                          let url = link["href"],
                          let image = link["data-src"],
                          let subCategory = item.css("span[class*='term-badge']").first?.text?.clean,
                          let summary = item.css("div[class*='post-summary']").first?.text?.clean
                    else { continue }
                    
                    if summary.lowercased().contains(NewsService.unacepptedWords) || title.lowercased().contains(NewsService.unacepptedWords) {
                        continue
                    }
                    
                    let item = NewsItem(title: title,
                                        url: url,
                                        image: image,
                                        summary: summary,
                                        category: categoryTitle,
                                        subCategory: subCategory)
                    DispatchQueue.main.async {
                        if !self.highlightedItems.contains(item) {
                            self.highlightedItems.append(item)
                        }
                    }
                }
            }

        }

    }
    
    func getHomeNews(_ completion: @escaping (() -> Void)) {
        
        guard let url = URL(string: Constant.Web.newsURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let html = String(data: data, encoding: .utf8),
                  let self = self,
                  let doc = try? HTML(html: html, encoding: .utf8)
            else {
                completion()
                return
            }
            
            for container in doc.xpath("//div[contains(@class, 'bs-vc-wrapper wpb_wrapper')]") {
                
                self.getHighlightedNews(inContainer: container)
                self.getNews(inContainer: container)
            }
            
            if self.highlightedItems.count == 0 && self.items.count > 3 {
                DispatchQueue.main.async {
                    let subItems = self.items[0...1]
                    self.items = Array(self.items[2...self.items.count - 1])
                    self.highlightedItems = Array(subItems)
                }
            }
            DispatchQueue.main.async {
                self.minWidth = UIScreen.main.bounds.size.width * CGFloat(self.highlightedItems.count)
                completion()
            }
        }
        
       
        
        task.resume()
    }
}
