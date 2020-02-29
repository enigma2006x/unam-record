//
//  SubjectRow.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct SubjectRow: View {
    var subject: Subject
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(subject.name ?? "")
            }
            VStack(alignment: .leading) {
               Text(subject.qualification ?? "")
            }
            Spacer()
        }
    }
}
