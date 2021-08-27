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
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.key == rhs.key
    }
}
