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
                        ForEach(userDataViewModel.academicItems) { item in
                            Section(header: Text(item.campus)) {
                                NavigationLink(destination: SubjectView(academicItem: item)) {
                                    AcademicRow(item: item)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Trayectoria Académica")
        }
    }
}
