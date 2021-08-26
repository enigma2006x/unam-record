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
        VStack{
            ScrollView(.vertical) {
                VStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: Constant.Measurement.base2x) {
                            HStack(alignment: .top) {
                                Text("Clave Plantel")
                                    .font(.subheadline)
                                Spacer()
                                Text(subject.idCampus ?? "")
                                    .font(.subheadline)
                            }
                            HStack(alignment: .top) {
                                Text("Asignatura")
                                    .font(.subheadline)
                                Spacer()
                                Text(subject.name ?? "")
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
                                Text("Créditos")
                                    .font(.subheadline)
                                Spacer()
                                Text(subject.credits ?? "")
                                    .font(.subheadline)
                            }
                            HStack(alignment: .top) {
                                Text("Calificación")
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
                        }.padding(.top, Constant.Measurement.base2x)
                        
                        VStack(alignment: .leading, spacing: Constant.Measurement.base2x) {
                            HStack(alignment: .top) {
                                Text("Folio Acta")
                                    .font(.subheadline)
                                Spacer()
                                Text(subject.invoice ?? "")
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
                                Text("Ordinario")
                                    .font(.subheadline)
                                Spacer()
                                Text(subject.ord ?? "-")
                                    .font(.subheadline)
                            }
                            HStack(alignment: .top) {
                                Text("Extraordinario")
                                    .font(.subheadline)
                                Spacer()
                                Text(subject.ext ?? "-")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                }.padding(Constant.Measurement.base2x)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle(subject.name ?? "")
            
        }
    }
}

struct SubjectDetailView_Preview: PreviewProvider {
    static var previews: some View {
        SubjectDetailView(subject: Subject(id: 10,
                                           idCampus: "idCampus",
                                           idSubject: "idSubject",
                                           credits: "credits",
                                           qualification: "qualification",
                                           type: "type",
                                           name: "name",
                                           examType: "examType",
                                           period: "period",
                                           invoice: "invoice",
                                           group: "group",
                                           ord: "ord",
                                           ext: "ext"))
    }
}
