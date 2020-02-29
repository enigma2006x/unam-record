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
    
    var actionSheet: ActionSheet {
        get {
            let buttons: [ActionSheet.Button] = [.default(Text("Save")), .default(Text("Delete")), .destructive(Text("Cancel"))]
            return ActionSheet(title: Text("Action Sheet"), message: Text("Choose Option"), buttons: buttons)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                SwiftUIWebView(viewModel: WebViewModel(link: Constant.Web.main), networkManager: networkManager)
            }
            .navigationBarTitle(Text(Constant.Subject.title))
            .navigationBarItems(trailing:
                Button("List") {
                    self.showActionSheet.toggle()
                }
                .actionSheet(isPresented: $showActionSheet, content: {
                    self.actionSheet
                })
            )
        }
    }
}

extension TweetbotActionController: UIViewControllerRepresentable {
    public typealias UIViewControllerType = TweetbotActionController
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<TweetbotActionController>) -> TweetbotActionController {
        let actionController = TweetbotActionController()
       // actionController.addSection(Section())
//        actionController.addAction(Action("View Details", style: .default, handler: { action in
//            // do something useful
//        }))
//        actionController.addAction(Action("View Retweets", style: .default, handler: { action in
//            // do something useful
//        }))
//        actionController.addAction(Action("View in Favstar", style: .default, handler: { action in
//            // do something useful
//        }))
//        actionController.addAction(Action("Translate", style: .default, executeImmediatelyOnTouch: true, handler: { action in
//            // do something useful
//        }))
        
       
//        actionController.addAction(Action("Cancel", style: .cancel, handler:nil))
        return actionController
    }
    
    public func updateUIViewController(_ uiViewController: TweetbotActionController, context: UIViewControllerRepresentableContext<TweetbotActionController>) {
        
    }
    
    func makeCoordinator() -> TweetbotActionController.Coordinator {
        return Coordinator(self)
    }
}

extension TweetbotActionController {
    class Coordinator: NSObject, UIFontPickerViewControllerDelegate {
        var parent: TweetbotActionController
        @Environment(\.presentationMode) var presentationMode
        
        init(_ parent: TweetbotActionController) {
            self.parent = parent
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
