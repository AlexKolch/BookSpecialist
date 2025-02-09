//
//  LeafButton.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 04.02.2025.
//

import SwiftUI

struct LeafButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .frame(maxWidth: .infinity, maxHeight: 57)
            .tint(.white)
            .font(.title3.weight(.bold))
            .background(
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 18, bottomLeading: 0, bottomTrailing: 18, topTrailing: 0))
//                    .fill(.darkGradient)
                    .fill(LinearGradient(colors: [.yellowBG, .darkGradient], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .stroke(.white, lineWidth: 0.7)
            )
    }
}

#Preview {
    LeafButton(title: "Вперед", action: {})
}
