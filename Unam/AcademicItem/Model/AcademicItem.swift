//
//  AcademicItem.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

struct AcademicItem: Equatable, Identifiable {
    let id: Int
    let key: String
    let campus: String
    let planName: String
    var campusId: String?
    var careerId: String?
    
    init(id: Int, key: String,
         campus: String,
         planName: String,
         campusId: String? = nil,
         careerId: String? = nil) {
        self.id = id
        self.key = key
        self.campus = campus.capitalized
        self.planName = planName.capitalized
        self.campusId = campusId
        self.careerId = careerId
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.key == rhs.key
    }
}
