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
    var idCampus: String?
    var idSubject: String?
    var credits: String?
    var qualification: String?
    var type: String?
    var name: String?
    var examType: String?
    var period: String?
    var invoice: String?
    var group: String?
    var ord: String?
    var ext: String?
}

struct SubjectSection: Identifiable {
    var id: Int
    var title: String
    var average: Double
    var results: [Subject]
    var totalPercentage: Double?
    
    init(id: Int,
         title: String,
         average: Double = 0,
         results: [Subject],
         totalPercentage: Double? = nil){
        self.id = id
        self.title = title
        self.average = average
        self.results = results
        self.totalPercentage = totalPercentage
    }
    
}
