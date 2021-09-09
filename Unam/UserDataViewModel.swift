//
//  UserDataViewModel.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 18/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

final class UserDataViewModel: ObservableObject {
    
    static let shared = UserDataViewModel()
    static var isLoadAcademicTrajectory = false
    static var htmlContains = false
    static var isLoadAcademicContent = false
    static let cookieName = "unam"
    
    @Published var accountImage = UIImage()
    @Published var accountID = ""
    @Published var accountFullName = ""
    @Published var isShowingAcademicItems = false
    @Published var isShowingSubjectItems = false
    @Published var subjectSections = [SubjectSection]()
    @Published var academicItems = [AcademicItem]()
    
    private init() { }
    
    func setTestAccount() {
        accountImage = UIImage.customShe
        accountID = "099321956"
        accountFullName = "Scarlett Marie"
    }
}


