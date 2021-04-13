//
//  TabContainerView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct TabContainerView: View {
    
    @ObservedObject private var networkManager = NetworkManager.shared
    
    var body: some View {
        if !networkManager.isShowingAcademicItems {
            SwiftUIWebView(networkManager: networkManager, mainURL: URL(string: "https://www.dgae-siae.unam.mx/www_gate.php"))
        } else {
        TabView {
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
            AcademicView()
                .tabItem {
                    Image(systemName: "doc.plaintext.fill")
                    Text("Trayectoria")
                }
        }
        }
    }
}
