//
//  String+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return lowercased().prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
