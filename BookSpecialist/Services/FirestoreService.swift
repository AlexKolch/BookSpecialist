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
    
    var profilesCollection: CollectionReference { bdLink.collection("profiles") } //ccылка на коллекцию профайлов в БД
    var slotsCollection: CollectionReference { bdLink.collection("slots") } //ссылка на слоты
    var mastersCollection: CollectionReference { bdLink.collection("masters") } //ссылка на мастеров
    
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
    
    //MARK: Getting master's slots
    func getSlotsbyMasterId(_ masterId: String) async throws -> [TimeSlot] {
        let documentSnapshot = try await slotsCollection.whereField("masterID", isEqualTo: masterId).getDocuments()
        
        let documents = documentSnapshot.documents
        let slots = documents.compactMap { doc in
            TimeSlot(snap: doc)
        }
        return slots
    }
    
    //MARK: Getting master
    func getMaster(byId: String) async throws -> Master {
        let documentSnapshot = try await mastersCollection.document(byId).getDocument()
        guard let representation = documentSnapshot.data() else {
            throw FirestoreError.dataNotFound
        }
        guard let master = Master(dictionary: representation) else { throw FirestoreError.wrongDataFormat}
        return master
    }
    
    //MARK: Booking TimeSlot
    func booking(timeSlot: TimeSlot, clientID: String) async throws {
        var repres = timeSlot.representation
        repres["clientID"] = clientID //создаем новое поле данных в FB
        try await slotsCollection.document(timeSlot.id).setData(repres)
    }
    
    enum FirestoreError: Error {
        case dataNotFound
        case wrongDataFormat
    }
}
