//
//  AcademicSubView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 06/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct AcademicSubView: View {
    
    @ObservedObject var userDataViewModel = UserDataViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ZStack(alignment: .top) {
                    Image(uiImage: userDataViewModel.accountImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .frame(width: 82, height: 82, alignment: .center)
                }.padding(Constant.Measurement.base)
                VStack(alignment: .leading) {
                    Text("Nombre")
                        .font(.title)
                        .foregroundColor(Color.customDarkBlue)
                        .bold()
                        .lineLimit(nil)
                        
                        .padding(.top, Constant.Measurement.base)
                    
                    Text(userDataViewModel.accountFullName)
                        .lineLimit(nil)
                        .font(.headline)
                        .padding(.top, Constant.Measurement.base)
                    
                    Text("")
                        .font(.title)
                        .foregroundColor(Color.customLightBlue)
                        .bold()
                        .frame(maxWidth: .infinity)
                    
                    Text("Cuenta")
                        .font(.title)
                        .foregroundColor(Color.customDarkBlue)
                        .bold()
                    
                    Text(userDataViewModel.accountID)
                        .lineLimit(nil)
                        .font(.headline)
                        .padding(.top, Constant.Measurement.base)
                }
               
            }
            
        }
        .padding(.leading, Constant.Measurement.base2x)
        .padding(.trailing, Constant.Measurement.base2x)
        .padding(.top, Constant.Measurement.base2x)
        .padding(.bottom, Constant.Measurement.base4x)
        .background(Image.customStudent2.resizable().opacity(0.25))
    }
    
}

struct AcademicSubView_Previews: PreviewProvider {
    
    static var previews: some View {
        AcademicSubView()
    }
}
