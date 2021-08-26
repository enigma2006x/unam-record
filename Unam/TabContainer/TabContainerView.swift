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
    init() {
        
       }
    var body: some View {
        if !userDataViewModel.isShowingAcademicItems {
            NavigationView {
                VStack(alignment: .center) {
                    UserDataWebModel(userDataViewModel: userDataViewModel, mainURL: URL(string: Constant.Web.mainURL))
                        .background(Color(UIColor.customBlue))
                }.edgesIgnoringSafeArea(.all)
                .background(Color(UIColor.customBlue))
                .navigationBarTitle("UNAM Mobile")
            }
           
        } else {
            TabView {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Perfil")
                    }
                AcademicView()
                    .tabItem {
                        Image(uiImage: UIImage(named: "doc")!)
                        Text("Trayectoria")
                    }
                NewsView()
                    .tabItem {
                        Image(uiImage: UIImage(named: "news")!)
                        Text("Gaceta")
                    }
            }.accentColor(colorScheme == .dark ? Color(.white) : Color(.customBlue))
        }
    }
}
