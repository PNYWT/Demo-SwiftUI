//
//  Extensions.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 7/3/2568 BE.
//

import SwiftUI
import UIKit

extension UIColor {
    static var lightBlue = #colorLiteral(red: 0.7481424825, green: 1, blue: 1, alpha: 1)
}

extension Color {
    static var lightBlue: Color {
        return Color(uiColor: .lightBlue)
    }
}
