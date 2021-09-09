//
//  Double+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 06/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

extension Double {
    func removeDecimals() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return String(formatter.string(from: number) ?? "0")
    }
    
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return String(formatter.string(from: number) ?? "")
    }
}
