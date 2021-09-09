//
//  SubjectHeaderView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 06/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct SubjectHeaderView: View {
   
    @ObservedObject var userDataViewModel = UserDataViewModel.shared
    var academicItem: AcademicItem
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text("Nombre del Plan de Estudio")
                .font(.title)
                .foregroundColor(Color.customDarkBlue)
                .bold()
                .lineLimit(nil)
                
                .padding(.top, Constant.Measurement.base)
            
            Text(academicItem.planName)
                .lineLimit(nil)
                .font(.headline)
                .padding(.top, Constant.Measurement.base)
            
            Text("")
                .font(.title)
                .foregroundColor(Color.customLightBlue)
                .bold()
                .frame(maxWidth: .infinity)
            
            Text("Plantel")
                .font(.title)
                .foregroundColor(Color.customDarkBlue)
                .bold()
            
            Text(academicItem.campus)
                .lineLimit(nil)
                .font(.headline)
                .padding(.top, Constant.Measurement.base)
            
            HStack(alignment: .top) {
                
                VStack {
                    Text("Promedio")
                        .font(.title)
                        .foregroundColor(Color.customDarkBlue)
                        .bold()
                        .padding(.top, Constant.Measurement.base)
                    
                    Text("\(userDataViewModel.subjectSections.first?.average.removeZerosFromEnd() ?? "-")")
                        .bold()
                        .lineLimit(nil)
                        .font(.title)
                        .padding(.top, Constant.Measurement.base3x)
                }
                Spacer()
                VStack {
                    Text("Avance total")
                        .font(.title)
                        .foregroundColor(Color.customDarkBlue)
                        .bold()
                        .padding(.top, Constant.Measurement.base)
                    RatingChart(value: userDataViewModel.subjectSections.first?.totalPercentage ?? 0).frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
            }
            
        }
        .padding(.leading, Constant.Measurement.base2x)
        .padding(.trailing, Constant.Measurement.base2x)
        .padding(.top, Constant.Measurement.base2x)
        .padding(.bottom, Constant.Measurement.base4x)
        .background(Image.customCity.resizable().opacity(0.25))
        
    }
    
}

struct SubjectHeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SubjectHeaderView(academicItem: AcademicItem(id: 15, key: "2323", campus: "Fac UNAM", planName: "Ingenieria"))
    }
}
