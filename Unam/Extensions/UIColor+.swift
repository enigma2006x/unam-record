//
//  UIColor+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 24/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var customGold: UIColor  {
        rgb(255, 215, 0)
    }
    
    static var customBlue: UIColor  {
        rgb(0, 40, 84)
    }
    
    private static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor {
        UIColor(red: r / 256, green: g / 256, blue: b / 256, alpha: a)
    }
    
}
