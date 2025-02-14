//
//  AuthService.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 14.02.2025.
//

import FirebaseAuth

actor AuthService {
    static let shared = AuthService(); private init() {}
    
    let authLink = Auth.auth() //ссылка на авторизацию (Authentication)
    var currentUser: User? { authLink.currentUser } //User в Authentication firebase
    
    //MARK: Auth
    func signIn(email: String, password: String) async throws -> Profile {
        let user = try await authLink.signIn(withEmail: email, password: password).user //получили юзера из firebase
        let profile = try await FirestoreService.shared.getProfile(id: user.uid)
        return profile
    }
    
    func signUp(email: String, password: String) async throws -> Profile {
        let user = try await authLink.createUser(withEmail: email, password: password).user //создали юзера в Authentication
       
        let profile = Profile(id: user.uid, name: "", email: email, phoneNumber: 0) //Cоздаем profile и связываем с user-ом из Authentication
        //отправляем profile в базу данных и возвращаем его
        return try await FirestoreService.shared.createProfile(profile)
    }
    
    //MARK: Exit
     func signOut() {
         try? authLink.signOut()
    }
}
