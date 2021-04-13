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
    @ObservedObject var networkManager = NetworkManager.shared
    @State private var isPresented = false
    @State var showActionSheet: Bool = false
    @State private var width: CGFloat = 0
    @State private var heigh: CGFloat = 0
    var academicItem: AcademicItem
    

    var actionSheet: ActionSheet {
        get {
            let printPDF = ActionSheet.Button.default(Text("PDF")) {
                SwiftUIWebView.customWebView.printContent()
            }
            let buttons: [ActionSheet.Button] = [printPDF, .destructive(Text("Cancel"))]
            return ActionSheet(title: Text(""), message: Text("Share:"), buttons: buttons)
        }
    }
    
    var body: some View {
        
        VStack {
            if !networkManager.isShowingSubjectItems {
                SwiftUIWebView(networkManager: networkManager, mainURL: URL(string: "https://www.dgae-siae.unam.mx/www_try.php?cta=" + networkManager.accountID + "&llave=" + academicItem.key + "&acc=hsa"))
            } else {
                
                List {
                    Text("Nombre del Plan de Estudio").font(.headline)
                    Text(academicItem.planName).font(.subheadline).lineLimit(nil)
                    
                    Text("Plantel").font(.headline)
                    Text(academicItem.campus).font(.subheadline).lineLimit(nil)
                    
                    ForEach(networkManager.subjectSections) { section in
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
        .navigationBarTitle("Historia Académica")
        .navigationBarItems(trailing:
                                Button(action: {
                                    showActionSheet.toggle()
                                }) {
                                    Image(systemName: "square.and.arrow.up").imageScale(.large)
                                }.opacity(networkManager.isShowingAcademicItems ? 1 : 0)
                                .actionSheet(isPresented: $showActionSheet, content: {
                                   actionSheet
                                })
        ).onAppear {
            networkManager.isShowingSubjectItems = false
        }
    }    
}
