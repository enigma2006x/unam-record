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
            HStack {
                VStack(alignment: .leading) {
                    Text(subject.name ?? "")
                        .font(.headline)
                        .foregroundColor(Color.customDarkBlue)
                    Text("Clave \(subject.idSubject ?? "")")
                        .padding(.top, Constant.Measurement.base)
                        .foregroundColor(Color.customRed)
                    Text("Créditos \(subject.credits ?? "")")
                        .padding(.top, Constant.Measurement.base)
                        .foregroundColor(Color.customRed)
                }.padding(Constant.Measurement.base)
                Spacer()
                HStack {
                    Text("Calif.")
                        .foregroundColor(Color.customDarkBlue)
                    Text(subject.qualification ?? "")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color.customDarkBlue)
                }.padding(Constant.Measurement.base)
            }
            .frame(maxWidth: .infinity)
            .background(Color.customGray)
            
        }
        .padding(.top, Constant.Measurement.base)
        .padding(.leading, Constant.Measurement.base)
        .padding(.bottom, Constant.Measurement.base)
        .padding(.trailing, Constant.Measurement.base)
    }
}

struct SubjectRow_Previews: PreviewProvider {
    static var previews: some View {
        SubjectRow(subject: Subject(id: 1, idSubject: "56329", credits: "20", qualification: "10", name: "Algebra Lineal"))
    }
}
