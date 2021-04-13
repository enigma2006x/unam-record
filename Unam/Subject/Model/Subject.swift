//
//  Subject.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

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

struct SubjectSection: Identifiable {
    var id: Int
    var title: String
    var results: [Subject]
}

