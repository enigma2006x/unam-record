//
//  MockProfileUI.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

struct MockProfileUI {
    private var academicTrajectory: String {
        Bundle.getHtmlFile("AcademicTrajectoryMock")
    }
    
    private var academicRecord: String {
        Bundle.getHtmlFile("AcademicTrajectoryMock")
    }
    
    init() {
        UserDataWebModel.dataSource = self
    }
    
}

extension MockProfileUI: UserDataWebModelDataSource {
    func getAcademicTrajectory() -> String {
        academicTrajectory
    }

    func getAcademicRecord() -> String {
        academicRecord
    }
}
