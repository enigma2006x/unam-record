//
//  NewsItemDetail.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 10/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

struct ImageDetail: Identifiable {
    let id: UUID = UUID()
    let url: String
}

struct NewsItemDetail: Identifiable {
    let id: UUID = UUID()
    let title: String
    let subtitle: String
    let author: String
    let time: String
    let content: String
    var images: [ImageDetail]
    let category: String
    let subCategory: String
}
