//
//  NetworkMock.swift
//  UnamUnitTests
//
//  Created by Jose Antonio Trejo Flores on 26/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation
@testable import Unam

enum TestContant {
    static let accountID = "accountIDValue"
    static let accountFullName = "accountFullNameValue"
    static let isShowingAcademicItems = true
    static let isShowingSubjectItems = true
    static let subjectSectionsIds = [1, 2, 3]
    static let academicItemIds = [1, 2, 3, 6, 7]
}

final class NetworkMock {
    
    func loadProfileMockRequest(completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            UserDataViewModel.shared.accountID = TestContant.accountID
            UserDataViewModel.shared.accountFullName = TestContant.accountFullName
            UserDataViewModel.shared.isShowingAcademicItems = TestContant.isShowingAcademicItems
            UserDataViewModel.shared.isShowingSubjectItems = TestContant.isShowingSubjectItems
            completion()
        }
    }
    
    func loadHistoricalRecordMockRequest(completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            
            let subSections = TestContant.subjectSectionsIds.map({ SubjectSection(id: $0, title: "Title \($0)", results: []) })
            UserDataViewModel.shared.subjectSections = subSections
            completion()
        }
    }
    
    func loadHistoricalRecordDetailsMockRequest(completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            
            let items = TestContant.academicItemIds.map({ AcademicItem(id: $0, key: String($0), campus: "Campus \($0)", planName: "Name \($0)") })
            UserDataViewModel.shared.academicItems = items
            completion()
        }
    }
}
