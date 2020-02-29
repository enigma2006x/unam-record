//
//  SubjectListView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
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
            }.navigationBarTitle(Text(Constant.Subject.title))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
