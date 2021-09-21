//
//  NewsDetailService.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 09/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation
import Kanna

final class NewsDetailService: ObservableObject {
    
    @Published var itemDetail = NewsItemDetail(title: "",
                                               subtitle: "",
                                               author: "",
                                               time: "",
                                               content: "",
                                               images: [],
                                               category: "",
                                               subCategory: "")
    
    func getNewsDetail(ofNewsItem item: NewsItem) {
        
        guard let url = URL(string: item.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let html = String(data: data, encoding: .utf8),
                  let self = self,
                  let doc = try? HTML(html: html, encoding: .utf8)
            else { return }
            
            guard let article = doc.css("article").first,
                  let title = article.css("span[class='post-title']").first?.text?.clean,
                  let author = article.css("span[class='autor']").first?.text?.clean,
                  let time = article.css("time").first?.text?.clean,
                  let content = article.css("div[class='entry-content clearfix single-post-content']").first?.text?.clean else { return }
    
            let subtitle = article.css("span[class='post-subtitle'], h2[class='post-subtitle']").first?.text?.clean ?? ""
            var images = [ImageDetail]()
            let imageItems = article.css("img")
            if imageItems.count > 1 {
                
                images = imageItems.compactMap({ (element) -> ImageDetail? in
                    if let src = element["data-src"] {
                        return ImageDetail(url: src)
                    }
                    
                    if let src = element["src"] {
                        return ImageDetail(url: src)
                    }
                    
                    return nil
                })
            } else {
                images = [ImageDetail(url: item.image)]
            }
            
            if images.count == 1 {
                
                let tempImage = images.first
                images.insert(ImageDetail(url: item.image), at: 0)
                
                if let tempImage = tempImage {
                    images.insert(tempImage, at: 1)
                }
                
            }
            
            let item = NewsItemDetail(title: title,
                                      subtitle: subtitle,
                                      author: author,
                                      time: time,
                                      content: content,
                                      images: images,
                                      category: item.category,
                                      subCategory: item.subCategory)
            DispatchQueue.main.async {
                self.itemDetail = item
            }
        }
        task.resume()
    }
}
