//
//  Color+Ext.swift
//  SwiftUI-Grid
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(red: Double.random(in: 0...1),
                     green: Double.random(in: 0...1),
                     blue: Double.random(in: 0...1))
    }
}
