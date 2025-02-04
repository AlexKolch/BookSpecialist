//
//  LeafTextField.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 04.02.2025.
//

import SwiftUI

struct LeafTextField: View {
    
    let isSecure: Bool
    let placeholder: String
    
    @State private var isSecurePassword: Bool
    @Binding var text: String
    
    init(isSecure: Bool, placeholder: String, text: Binding<String>) {
        self.isSecure = isSecure
        self.placeholder = placeholder
        self._text = text
        self.isSecurePassword = isSecure
    }
    
    var body: some View {
        HStack {
            //если режим отображения пароля защищенный, рисуется SecureField.
            if isSecurePassword {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text) //если не SecureField рисуется обычный
            }
            Spacer()
            //если это SecureField посторить кнопку отображения пароля
            if isSecure {
                Button(action: {
                    self.isSecurePassword.toggle() //меняет видимость защищенного пароля
                }) {
                    Image(systemName: isSecurePassword ? "eye.fill" : "eye.slash.fill")
                        .resizable()
                        .frame(width: 26.5, height: 16.5)
                }
                .tint(.selectedDate)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 21)
        .background(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 18, bottomLeading: 0, bottomTrailing: 18, topTrailing: 0))
                .fill(.white)
                .stroke(.lightGray)
        )
    }
}

#Preview {
    LeafTextField(isSecure: true, placeholder: "Введите значение", text: .constant(""))
}
