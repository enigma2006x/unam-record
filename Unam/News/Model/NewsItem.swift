//
//  NewsItem.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 09/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct NewsItem: Identifiable {
    
    let id: UUID = UUID()
    let title: String
    let url: String
    let image: String
    let summary: String
    let category: String
    let subCategory: String
    
    init() {
        title = ""
        url = ""
        image = ""
        summary = ""
        category = ""
        subCategory = ""
    }
    
    init(title: String,
         url: String,
         image: String,
         summary: String,
         category: String,
         subCategory: String) {
        self.title = title
        self.url = url
        self.image = image
        self.summary = summary
        self.category = category
        self.subCategory = subCategory
    }
}

extension NewsItem: Equatable {
    static func ==(lhs: NewsItem, rhs: NewsItem) -> Bool {
        return lhs.title == rhs.title && lhs.url == rhs.url
    }
}
