//
//  View+.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 04/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

extension View {
    func hideRowSeparator(insets: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                          background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}

struct HideRowSeparatorModifier: ViewModifier {

  static let defaultListRowHeight: CGFloat = 44

  var insets: EdgeInsets
  var background: Color

  init(insets: EdgeInsets, background: Color) {
    self.insets = insets

    var alpha: CGFloat = 0
    if #available(iOS 14.0, *) {
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1, "Setting background to a non-opaque color will result in separators remaining visible.")
    }
    self.background = background
  }

  func body(content: Content) -> some View {
    content
        .padding(insets)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: Self.defaultListRowHeight)
        .listRowInsets(EdgeInsets())
        .overlay(
            VStack {
                HStack {}
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(background)
                Spacer()
                HStack {}
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(background)
            }
            .padding(.top, -1)
        )
  }
}
