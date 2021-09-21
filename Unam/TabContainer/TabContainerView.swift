//
//  TabContainerView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct TabContainerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var userDataViewModel = UserDataViewModel.shared
    
    @State private var opacity: Double = 1
    
    var body: some View {
        if !userDataViewModel.isShowingAcademicItems {
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: Constant.Measurement.base2x) {
                    HStack {
                        Text("UNAM Mobile")
                            .foregroundColor(.white)
                            .bold()
                            .font(Appearance.hasTopNotch ? .largeTitle : .title)
                            .frame(maxWidth: .infinity, maxHeight: Constant.Measurement.base12x)
                        
                    }.padding(.top, Appearance.hasTopNotch ? Constant.Measurement.base3x : Constant.Measurement.base4x)
                    
                    UserDataWebModel(userDataViewModel: userDataViewModel,
                                     mainURL: URL(string: Constant.Web.mainURL))
                    
                }.background(
                    VStack(alignment: .leading) {
                        Image.customFibo
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.customGold)
                            .opacity(opacity)
                        
                    }
                    .background(Color.customBlue)
                    
                ).edgesIgnoringSafeArea(.all)
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .edgesIgnoringSafeArea(.all)
            .background(Color.customBlue)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    withAnimation(.easeInOut(duration: 1.5), {
                        self.opacity = 0.35
                    })
                }
            })
            
            
            
        } else {
            TabView {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Perfil")
                    }
                AcademicView()
                    .tabItem {
                        Image.customDoc
                        Text("Trayectoria")
                    }
                NewsView()
                    .tabItem {
                        Image.customNews
                        Text("Noticias")
                    }
            }.edgesIgnoringSafeArea(.all)
            .accentColor(Color.customGold)
        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}
