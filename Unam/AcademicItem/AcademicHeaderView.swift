//
//  AcademicHeaderView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 04/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct AcademicHeaderView: View {
    
    let title: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.customDarkBlue)
                    .bold()
                Spacer()
            }
            Spacer()
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color.white)
        .padding(.leading, Constant.Measurement.base2x)
        .padding(.top, Constant.Measurement.base)
        .padding(.trailing, Constant.Measurement.base2x)
    }
    
}

struct AcademicHeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AcademicHeaderView(title: "Primer Semestre")
    }
}
