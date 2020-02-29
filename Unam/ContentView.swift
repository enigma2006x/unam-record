//
//  ContentView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 18/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Combine


class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    
    init (link: String) {
        self.link = link
    }
}

class NetworkManager: ObservableObject {
    //var didChange = PassthroughSubject<NetworkManager, Never>()
    @Published var subjectSections: [SubjectSection] = []
}

var cookieName = "unam"
//https://www.codepunker.com/blog/proper-communication-between-javascript-in-wkwebview-and-swift
var userId = ""
