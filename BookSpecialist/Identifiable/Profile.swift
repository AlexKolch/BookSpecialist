//
//  Profile.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 14.02.2025.
//

import Foundation

final class Profile: Identifiable {
    let id: String
    let name: String
    let email: String
    let phoneNumber: Int
    
    init(id: String, name: String, email: String, phoneNumber: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    ///init для создания profile из firestore
    convenience init?(_ representation: [String: Any]) {
        guard let id = representation["id"] as? String,
              let name = representation["name"] as? String,
              let email = representation["email"] as? String,
              let phoneNumber = representation["phoneNumber"] as? Int
        else { return nil }
        
        self.init(id: id, name: name, email: email, phoneNumber: phoneNumber)
    }
    
}

extension Profile {
    var representation: [String: Any] {
        var representation: [String: Any] = [
            "id": id,
            "name": name,
            "email": email,
            "phoneNumber": phoneNumber
        ]
        return representation
    }
}
