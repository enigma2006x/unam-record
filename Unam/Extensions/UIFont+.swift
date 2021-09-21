//
//  UIFont+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 03/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import SwiftUI

extension UIFont {
    static let mbSmall = UIFont(name: "HelveticaNeue", size: 12)
    static let mbRegular = UIFont(name: "HelveticaNeue", size: 24)
    static let mbBold = UIFont(name: "HelveticaNeue-Bold", size: 28)
    static let mbTitle = UIFont(name: "HelveticaNeue-Bold", size: 20)
}

extension Font {
    static let mbTitle = Font(UIFont.mbTitle!)
}
