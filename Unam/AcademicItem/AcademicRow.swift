//
//  AcademicRow.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 04/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct AcademicRow: View {
    var item: AcademicItem
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(item.planName)
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color.customDarkBlue)
                    Text("Plantel \(item.campusId?.isEmpty ?? true ? "-" : (item.campusId ?? "-"))")
                        .font(.headline)
                        .foregroundColor(Color.customDarkBlue)
                        .padding(.top, Constant.Measurement.base2x)
                    
                    Text("Carrera \(item.careerId?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true ? "-" : (item.careerId ?? "-"))")
                        .font(.headline)
                        .foregroundColor(Color.customDarkBlue)
                        .padding(.top, Constant.Measurement.base)
                }
                Spacer()
                Image.customRightArrow2.frame(width: 45, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding(.leading, Constant.Measurement.base)
            .padding(.trailing, Constant.Measurement.base)
            .padding(.top, Constant.Measurement.base3x)
            .padding(.bottom, Constant.Measurement.base3x)
            .frame(maxWidth: .infinity)
            .background(Color.customGray)
        }
        .padding(.top, Constant.Measurement.base)
        .padding(.leading, Constant.Measurement.base)
        .padding(.bottom, Constant.Measurement.base)
        .padding(.trailing, Constant.Measurement.base)
    }
}

struct AcademicRow_Previews: PreviewProvider {
    static var previews: some View {
        AcademicRow(item: AcademicItem(id: 10, key: "203", campus: "Fac Ing", planName: "FACULTAD INGENIERIA", campusId: "0027", careerId: "0011"))
    }
}
