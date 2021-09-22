//
//  UnamUnitTests.swift
//  UnamUnitTests
//
//  Created by Jose Antonio Trejo Flores on 26/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import XCTest
@testable import Unam

final class UnamUnitTests: XCTestCase {
    
    private var shared: UserDataViewModel!
    
    override func setUp() {
        super.setUp()
        shared = UserDataViewModel.shared
    }
    
    override func tearDown() {
        shared = nil
        super.tearDown()
    }
    
    func testProfileData() {
        
        let promise = expectation(description: "testProfileData")
        let networkMock = NetworkMock()
        networkMock.loadProfileMockRequest(completion: {
            
            XCTAssertEqual(self.shared.accountID, TestContant.accountID)
            XCTAssertEqual(self.shared.accountFullName, TestContant.accountFullName)
            XCTAssertEqual(self.shared.isShowingAcademicItems, TestContant.isShowingAcademicItems)
            XCTAssertEqual(self.shared.isShowingSubjectItems, TestContant.isShowingSubjectItems)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 4)
    }
   
    
    func testHistoricalRecord() {
        
        let promise = expectation(description: "testHistoricalRecord")
        let networkMock = NetworkMock()
        networkMock.loadHistoricalRecordMockRequest(completion: {
            
            XCTAssertEqual(self.shared.subjectSections.count, 3)
            
            for id in TestContant.subjectSectionsIds {
                let subjectSection = SubjectSection(id: id, title: "Title \(id)", results: [])
                
                let valueExists = self.shared.subjectSections.contains(where: { $0.id == subjectSection.id && $0.title == subjectSection.title && $0.results.count == subjectSection.results.count })
                XCTAssertTrue(valueExists)
            }
            
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 4)
    }
    
    func testHistoricalRecordDetails() {
        
        let promise = expectation(description: "testHistoricalRecordDetails")
        let networkMock = NetworkMock()
        networkMock.loadHistoricalRecordDetailsMockRequest(completion: {
            
            XCTAssertEqual(self.shared.academicItems.count, 5)
            
            for id in TestContant.subjectSectionsIds {
                let subjectSection = AcademicItem(id: id, key: String(id), campus: "Campus \(id)", planName: "Name \(id)")
                let valueExists = self.shared.academicItems.contains(where: { $0.id == subjectSection.id && $0.key == subjectSection.key && $0.campus == subjectSection.campus && $0.planName == subjectSection.planName })
                XCTAssertTrue(valueExists)
            }
            
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 4)
    }
   
}
