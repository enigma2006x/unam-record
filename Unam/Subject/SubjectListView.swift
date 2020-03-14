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

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var isPresented = false
    @State var showActionSheet: Bool = false
    

    
    @State private var width: CGFloat = 0
    @State private var heigh: CGFloat = 0
    
    var actionSheet: ActionSheet {
        get {
            let buttons: [ActionSheet.Button] = [.default(Text("Pdf")), .destructive(Text("Cancel"))]
            return ActionSheet(title: Text(""), message: Text("Share:"), buttons: buttons)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !networkManager.showSubjectList {
                    SwiftUIWebView(viewModel: WebViewModel(link: Constant.Web.main), networkManager: networkManager)
                } else {
                    List {
                                           ForEach(networkManager.subjectSections) { section in
                                               Section(header: Text(section.title ?? "")) {
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
            
//            VStack {
//            //    if networkManager.showSubjectList {
//
//           //     }
//            }
            .navigationBarTitle(Text(Constant.Subject.title))
            .navigationBarItems(trailing:
                
//                Button("List") {
//                    self.showActionSheet.toggle()
//                    Image(systemName: "person.crop.circle").imageScale(.large)
//                }
                Button(action: {
                      self.showActionSheet.toggle()
                   }) {
                       Image(systemName: "square.and.arrow.up").imageScale(.large)
                }.opacity(networkManager.showSubjectList ? 1 : 0)
                .actionSheet(isPresented: $showActionSheet, content: {
                    self.actionSheet
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
