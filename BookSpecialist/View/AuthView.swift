//
//  AuthView.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 09.02.2025.
//

import SwiftUI

struct AuthView: View {
    @State private var isAuth: Bool = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Bindable var routeObserved: RouteView.Observed
    
    var body: some View {
        VStack(spacing: 12.0) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .clipShape(.circle)
            Text("Book your specialist")
                .font(.title).bold()
                .foregroundStyle(.white)
                .padding(.top, 27)
                .padding(.bottom, 14)
            
            LeafTextField(isSecure: false, placeholder: "Введите ваш email", text: $email)
            LeafTextField(isSecure: true, placeholder: "Введите ваш пароль", text: $password)
            if !isAuth {
                LeafTextField(isSecure: true, placeholder: "Повторите ваш пароль", text: $confirmPassword)
            }
            
            LeafButton(title: isAuth ? "Войти" : "Присоединиться") {
                //TODO - change state app
                routeObserved.appState = .authorized
            }
            .padding(.bottom, 9)
            
            Button(isAuth ? "Еще не с нами?" : "Уже есть аккаунт?") {
                withAnimation {
                    isAuth.toggle()
                }
            }
            .font(.callout)
            .tint(.numberDate)
        }
        .padding(.horizontal, 43)
        .offset(y: -66.5)
    }
}


#Preview {
    RouteView()
}
