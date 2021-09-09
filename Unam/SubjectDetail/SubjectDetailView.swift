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
        
        VStack {
            ZStack {
                ScrollView(.vertical) {
                    VStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: Constant.Measurement.base4x) {
                                HStack(alignment: .top) {
                                    Text("Clave Plantel")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.idCampus ?? "")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Asignatura")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.name ?? "")
                                        .font(.headline).bold().multilineTextAlignment(.trailing)
                                }
                                HStack(alignment: .top) {
                                    Text("Clave Asignatura")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.idSubject ?? "")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Créditos")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.credits ?? "")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Calificación")
                                        .font(.headline)
                                    Spacer()
                                    Text((subject.type ?? "") + " " + (subject.qualification ?? ""))
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Tipo de Examen")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.examType ?? "")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Periodo")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.period ?? "")
                                        .font(.headline).bold()
                                }
                            }.padding(.top, Constant.Measurement.base2x)
                            
                            VStack(alignment: .leading, spacing: Constant.Measurement.base4x) {
                                HStack(alignment: .top) {
                                    Text("Folio Acta")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.invoice ?? "")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Grupo")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.group ?? "")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Ordinario")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.ord ?? "-")
                                        .font(.headline).bold()
                                }
                                HStack(alignment: .top) {
                                    Text("Extraordinario")
                                        .font(.headline)
                                    Spacer()
                                    Text(subject.ext ?? "-")
                                        .font(.headline).bold()
                                }
                                
                            }.padding(.top, Constant.Measurement.base2x)
                        }
                        
                    }.padding(Constant.Measurement.base2x)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
        }.background( VStack {
            Spacer()
            VStack(alignment: .leading) {
                Image.customCareer.resizable().opacity(0.45)
            }.frame(maxHeight: 280)
        }.background(Color.customGray))
        .navigationBarTitle(subject.name ?? "")
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
