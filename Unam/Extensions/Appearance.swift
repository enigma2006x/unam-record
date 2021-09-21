//
//  Appearance.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 25/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import SwiftUI

enum Appearance {
    static func loadAppearance() {
        loadAppearanceNavigationBar()
        loadAppearanceTabBar()
        
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    static func loadAppearanceNavigationBar() {
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
    
    static func loadAppearanceTabBar() {
        let newAppearance = UITabBarAppearance()
        newAppearance.configureWithOpaqueBackground()
        newAppearance.backgroundColor = UIColor.customBlue
        
        UITabBar.appearance().barTintColor = UIColor.customBlue
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().standardAppearance = newAppearance
    }
    
    static var hasTopNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}
