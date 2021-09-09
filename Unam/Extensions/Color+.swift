//
//  UIColor+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 24/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import SwiftUI

extension UIColor {
    
    static var customGold: UIColor {
        rgb(255, 215, 0)
    }
    
    static var customLightBlue: UIColor {
        rgb(6, 98, 178)
    }
    
    static var customBlue: UIColor {
        rgb(0, 40, 84)
    }
    
    static var customDarkBlue: UIColor {
        rgb(4, 4, 20)
    }
    
    static var customDarkGreen: UIColor {
        rgb(66, 97, 49)
    }
    
    static var customRed: UIColor {
        rgb(50, 19, 12)
    }
    
    static var customGray: UIColor {
        rgb(224, 231, 241)
    }
    
    private static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor {
        UIColor(red: r / 256, green: g / 256, blue: b / 256, alpha: a)
    }
    
}

extension Color {
    static var customGold: Color {
        Color(UIColor.customGold)
    }
    
    static var customLightBlue: Color {
        Color(UIColor.customLightBlue)
    }
    
    static var customBlue: Color {
        Color(UIColor.customBlue)
    }
    
    static var customDarkBlue: Color {
        Color(UIColor.customDarkBlue)
    }
    
    static var customDarkGreen: Color {
        Color(UIColor.customDarkGreen)
    }
    
    static var customRed: Color {
        Color(UIColor.customRed)
    }
    
    static var customGray: Color {
        Color(UIColor.customGray)
    }
}
