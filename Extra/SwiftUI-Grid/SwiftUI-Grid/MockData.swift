//
//  MockData.swift
//  SwiftUI-Grid
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct MockData {
    static var colors: [Color] {
        var array: [Color] = []
        for _ in 0..<30 {
            array.append(Color.random)
        }
        return array
    }
}
