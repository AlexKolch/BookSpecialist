//
//  FirestoreService.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 14.02.2025.
//
import Foundation
import FirebaseFirestore

actor FirestoreService {
    static let shared = FirestoreService(); private init() {}
    let bdLink = Firestore.firestore()
    
    var profilesCollection: CollectionReference {
        bdLink.collection("profiles") //ccылка на профайлы в коллекции БД
    }
    
    //MARK: Create profile
    func createProfile(_ profile: Profile) async throws -> Profile {
        try await profilesCollection.document(profile.id).setData(profile.representation)
        return profile
    }
    
    //MARK: Getting profile
    func getProfile(id: String) async throws -> Profile {
        let documentSnapshot = try await profilesCollection.document(id).getDocument() //получили снимок db
        guard let representation = documentSnapshot.data() else { //получили словарь в котором лежит профиль
            throw FirestoreError.dataNotFound
        }
        
        guard let profile = Profile(representation) else { //создаем наш profile из модели profile в db
            throw FirestoreError.wrongDataFormat
        }
        
        return profile
    }
    
    enum FirestoreError: Error {
        case dataNotFound
        case wrongDataFormat
    }
}
