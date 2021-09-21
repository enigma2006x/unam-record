//
//  String+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        let value = self.replacingOccurrences(of: "-", with: " ")
        return value.lowercased().prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func base64ToImage() -> UIImage? {
        if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}

extension String {
    func contains(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
    
    var clean: String {
        String(self.filter { !"\n\t\r".contains($0) })
            .replacingOccurrences(of: "</em>", with: "")
            .replacingOccurrences(of: "<em>", with: "")
            .replacingOccurrences(of: "images:", with: "")
            .replacingOccurrences(of: "&nbsp", with: "")
            .replacingOccurrences(of: "Humanidades Comunidad", with: "Humanidades")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
