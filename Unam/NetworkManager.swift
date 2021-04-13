//
//  NetworkManager.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 18/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

final class NetworkManager: ObservableObject {
    @Published var accountImage = UIImage()
    @Published var accountID = ""
    @Published var accountFullName = ""
    @Published var isShowingAcademicItems = false
    @Published var isShowingSubjectItems = false
    @Published var subjectSections = [SubjectSection]()
    @Published var academicItems = [AcademicItem]()
    
    static let shared = NetworkManager()
    static var isLoadAcademicTrajectory = false
    static var htmlContains = false
    static var isLoadAcademicContent = false
    static let cookieName = "unam"
    
    private init() { }
}


