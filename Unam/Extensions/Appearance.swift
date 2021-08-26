//
//  Appearance.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 25/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit

enum Appearance {
    static func loadAppearance() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.configureWithOpaqueBackground()

        newAppearance.backgroundColor = .customBlue
        newAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        newAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = newAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = newAppearance
        UINavigationBar.appearance().compactAppearance = newAppearance
        // change color of navigationbar items
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}
