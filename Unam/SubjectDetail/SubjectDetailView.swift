//
//  SubjectDetailView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct SubjectDetailView: View {
    var subject: Subject
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                VStack(alignment: .leading) {
                    Text(subject.name ?? "")
                        .font(.largeTitle)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .padding(.leading, Constant.Measurement.base2x)
                        .padding(.trailing, Constant.Measurement.base2x)
                        .padding(.bottom, Constant.Measurement.base2x)
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: Constant.Measurement.base2x) {
                        HStack(alignment: .top) {
                            Text("Clave Plantel")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.idPlantel ?? "")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Clave Asignatura")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.idSubject ?? "")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Creditos")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.credits ?? "")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Calificacion")
                                .font(.subheadline)
                            Spacer()
                            Text((subject.type ?? "") + " " + (subject.qualification ?? ""))
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Tipo de Examen")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.examType ?? "")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Periodo")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.period ?? "")
                                .font(.subheadline)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: Constant.Measurement.base2x) {
                        HStack(alignment: .top) {
                            Text("Folio Acta")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.folio ?? "")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Grupo")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.group ?? "")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Ord")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.ord ?? "-")
                                .font(.subheadline)
                        }
                        HStack(alignment: .top) {
                            Text("Ext")
                                .font(.subheadline)
                            Spacer()
                            Text(subject.ext ?? "-")
                                .font(.subheadline)
                        }
                    }.padding(.top, Constant.Measurement.base3x)
                }.padding(Constant.Measurement.base)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SubjectDetailView_Preview: PreviewProvider {
    static var previews: some View {
        SubjectDetailView(subject: Subject(id: 10,
                                           idPlantel: "idPlantel",
                                           idSubject: "idSubject",
                                           credits: "credits",
                                           qualification: "qualification",
                                           type: "type",
                                           name: "name",
                                           examType: "examType",
                                           period: "period",
                                           folio: "folio",
                                           group: "group",
                                           ord: "ord",
                                           ext: "ext"))
    }
}
