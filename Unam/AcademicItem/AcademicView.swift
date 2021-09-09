//
//  AcademicView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct AcademicView: View {
    @ObservedObject var userDataViewModel = UserDataViewModel.shared
    @State private var isPresented = false
    @State var showActionSheet: Bool = false
    @State private var width: CGFloat = 0
    @State private var heigh: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if !userDataViewModel.isShowingAcademicItems {
                    UserDataWebModel(userDataViewModel: userDataViewModel, mainURL: URL(string: Constant.Web.mainURL))
                } else {
                    List {
                        VStack(alignment: .leading, spacing: 0) {
                            AcademicSubView()
                        }
                        .background(Color.customGray)
                        .listRowInsets(EdgeInsets())
                        
                        ForEach(userDataViewModel.academicItems) { section in
                            Section(header: AcademicHeaderView(title: section.campus)
                                        .background(Color.white)
                                        .listRowInsets(EdgeInsets())) {
                            
                                    ZStack {
                                        AcademicRow(item: section).listRowInsets(EdgeInsets())
                                        NavigationLink(destination: SubjectView(academicItem: section)) {
                                        }.buttonStyle(PlainButtonStyle()).frame(width:0).opacity(0)
                                    }.hideRowSeparator(background: .white)
                            
                            }
                        }
                    }.listStyle(PlainListStyle())
                }
            }.navigationBarTitle("Trayectoria Académica", displayMode: Appearance.hasTopNotch ? .large : .inline)
            .onAppear(perform: {
                Constant.isLoadingNewList = true
            })
        }
    }
}

struct AcademicView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AcademicView()
    }
}
