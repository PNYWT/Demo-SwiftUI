//
//  OffsetKey.swift
//  SwiftUI-ScrollViewSwipeAction
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

/*
 - protocol ที่ใช้ส่งข้อมูลจาก child view → parent view ใน SwiftUI layout system
 - ใช้คู่กับ .background(GeometryReader { ... })
 - เหมาะกับการ track position, size, scroll offset ฯลฯ
 */
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
