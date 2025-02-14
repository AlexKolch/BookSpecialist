//
//  AuthObserved.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 14.02.2025.
//

import Foundation

extension AuthView {
    @Observable
    class Observed {
        var currentProfile: Profile?
        
        func login(email: String, password: String) {
            Task {
                let profile = try await AuthService.shared.signIn(email: email, password: password)
                await MainActor.run {
                    self.currentProfile = profile
                }
            }
        }
        
        func register(email: String, password: String, confirmPassword: String) {
            guard password == confirmPassword else { return }
            Task {
                let profile = try await AuthService.shared.signUp(email: email, password: password)
                await MainActor.run {
                    self.currentProfile = profile
                }
            }
        }
    }
}
