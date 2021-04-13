//
//  AcademicView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import UIKit

struct AcademicView: View {
    @ObservedObject var networkManager = NetworkManager.shared
    @State private var isPresented = false
    @State var showActionSheet: Bool = false
    @State private var width: CGFloat = 0
    @State private var heigh: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if !networkManager.isShowingAcademicItems {
                    SwiftUIWebView(networkManager: networkManager, mainURL: URL(string: "https://www.dgae-siae.unam.mx/www_gate.php"))
                } else {
                    
                    List {
                        ForEach(networkManager.academicItems) { item in
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
