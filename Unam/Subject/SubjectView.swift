//
//  SubjectListView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import UIKit
import XLActionController
import QuickLook

struct SubjectView: View {
    
    @ObservedObject var userDataViewModel = UserDataViewModel.shared
    @State private var isPresented = false
    @State var showActionSheet: Bool = false
    @State private var width: CGFloat = 0
    @State private var heigh: CGFloat = 0
    
    var academicItem: AcademicItem
    
    var actionSheet: ActionSheet {
        get {
            let printPDF = ActionSheet.Button.default(Text("Imprimir")) {
                UserDataWebModel.customWebView.printContent()
            }
            
            let shareContent = ActionSheet.Button.default(Text("Compartir")) {
                UserDataWebModel.customWebView.shareContent()
            }
            
            let buttons: [ActionSheet.Button] = [printPDF, shareContent, .destructive(Text("Cancelar"))]
            return ActionSheet(title: Text(""), message: Text("Share:"), buttons: buttons)
        }
    }
    
    var body: some View {
        
        VStack {
            if !userDataViewModel.isShowingSubjectItems {
                let detailURL = Constant.Web.academicDetails(accountID: userDataViewModel.accountID, academicKey: academicItem.key)
                UserDataWebModel(userDataViewModel: userDataViewModel, mainURL: URL(string: detailURL))
            } else {
                
                List {
                    Text("Nombre del Plan de Estudio").font(.headline)
                    Text(academicItem.planName).font(.subheadline).lineLimit(nil)
                    
                    Text("Plantel").font(.headline)
                    Text(academicItem.campus).font(.subheadline).lineLimit(nil)
                    
                    ForEach(userDataViewModel.subjectSections) { section in
                        Section(header: Text(section.title)) {
                            ForEach(section.results, id: \.id) { subject in
                                NavigationLink(destination: SubjectDetailView(subject: subject)) {
                                    SubjectRow(subject: subject)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Constant.SubjectDetail.title)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showActionSheet.toggle()
                                }) {
                                    Image(systemName: "square.and.arrow.up").imageScale(.large)
                                }.opacity(userDataViewModel.isShowingAcademicItems ? 1 : 0)
                                .actionSheet(isPresented: $showActionSheet, content: {
                                   actionSheet
                                })
        ).onAppear {
            userDataViewModel.isShowingSubjectItems = false
        }
    }    
}
