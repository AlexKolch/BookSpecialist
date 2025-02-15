//
//  Timeslot.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 26.01.2025.
//

import Foundation
import FirebaseFirestore

class TimeSlot: Identifiable {
    var id: String = UUID().uuidString
    var clientId: String?
    let masterId: String
    var date: Date
    var endDate: Date
    
    init(masterId: String, date: Date) {
        self.masterId = masterId
        self.date = date
        self.endDate = self.date.addingTimeInterval(3600) //1 час
    }
    
    ///failable init для создания слотов из слотов в Firebase
    init?(snap: QueryDocumentSnapshot) {
        let data = snap.data()
        guard let id = data["id"] as? String,
              let masterId = data["masterId"] as? String,
              let timestamp = data["date"] as? Timestamp,
              let endTimestamp = data["endDate"] as? Timestamp
        else { return nil }
        
        self.id = id
        self.masterId = masterId
        self.date = timestamp.dateValue()
        self.endDate = endTimestamp.dateValue()
        
        if let clientID = data["clientID"] as? String {
            self.clientId = clientID
        }
    }
    
}

extension TimeSlot {
    static let mockMasterId: String = "1"
    static let mockUserId: String = UUID().uuidString
    static let mackdata: [TimeSlot] = [
//        Timeslot(masterId: mockMasterId, date: .init(timeIntervalSince1970: 1)),
        TimeSlot(masterId: mockMasterId, date: .now),
        TimeSlot(masterId: mockMasterId, date: .now + 3600),
        TimeSlot(masterId: mockMasterId, date: .now + 7200),
    ]
}
