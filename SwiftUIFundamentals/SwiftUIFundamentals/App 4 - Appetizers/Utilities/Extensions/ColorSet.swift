//
//  ColorSet.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI
import UIKit

extension UIColor {
    static var darkGreen: UIColor {
        return UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
                .red : #colorLiteral(red: 0, green: 0.388, blue: 0.239, alpha: 1) 
        }
    }
}

extension Color {
    static let darkGreen = Color(uiColor: .darkGreen)
}
