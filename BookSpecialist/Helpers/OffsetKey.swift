//
//  OffsetKey.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 18.01.2025.
//

import Foundation
import SwiftUICore

///поможет перепрыгивать по неделям
struct OffsetKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}
