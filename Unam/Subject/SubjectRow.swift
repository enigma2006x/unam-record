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
            Spacer()
            VStack(alignment: .trailing) {
               Text(subject.qualification ?? "")
            }
            
        }.padding(Constant.Measurement.base)
    }
}

struct SubjectRow_Previews: PreviewProvider {
    static var previews: some View {
        SubjectRow(subject: Subject(id: 1, qualification: "qualification", name: "name"))
    }
}
