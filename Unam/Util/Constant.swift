//
//  Constant.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation
import UIKit

enum Constant {
    
    static var isDebugMode: Bool = false
    
    static var isLoadingNewList: Bool = true
    
    enum Web {
        static let mainURL = "https://www.dgae-siae.unam.mx/www_gate.php"
        static let academicRecordsURL = "https://www.dgae-siae.unam.mx/reg_try.html"
        static let gazetteURL = "https://www.gaceta.unam.mx/"
        
        static func academicDetails(accountID: String, academicKey: String) -> String {
            "https://www.dgae-siae.unam.mx/www_try.php?cta=" + accountID + "&llave=" + academicKey + "&acc=hsa"
        }
    }
    
    enum Subject {
        static let title = "UNAM"
    }
    
    enum SubjectDetail {
        static let title = "Historial Académico"
    }
    
    enum Measurement {
        static let base: CGFloat = 8
        static let base2x = base * 2
        static let base3x = base * 3
        static let base4x = base * 4
        static let base5x = base * 5
        static let base10x = base * 10
        static let base12x = base * 12
    }

    enum Pdf {
        static let title = "HistorialAcademico"
    }
    
}
