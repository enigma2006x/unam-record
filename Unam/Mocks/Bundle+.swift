//
//  Bundle+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 22/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

extension Bundle {
    static func getHtmlFile(_ name: String) -> String {
        guard let file = Bundle(for: SceneDelegate.self).path(forResource: name, ofType: "html"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: file)),
              let content = String(data: data, encoding: .utf8)
        else { fatalError() }
        return content
    }
}
