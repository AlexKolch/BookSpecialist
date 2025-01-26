//
//  Timeslot.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 26.01.2025.
//

import Foundation

class Timeslot: Identifiable {
    let id: UUID = .init()
    var clientId: String?
    let masterId: String
    var date: Date
    var endDate: Date
    
    init(masterId: String, date: Date) {
        self.masterId = masterId
        self.date = date
        self.endDate = self.date.addingTimeInterval(3600) //1 час
    }
    
}

extension Timeslot {
    static let mockMasterId: String = "1"
    static let mockUserId: String = UUID().uuidString
    static let mackdata: [Timeslot] = [
//        Timeslot(masterId: mockMasterId, date: .init(timeIntervalSince1970: 1)),
        Timeslot(masterId: mockMasterId, date: .now),
        Timeslot(masterId: mockMasterId, date: .now + 3600),
        Timeslot(masterId: mockMasterId, date: .now + 7200),
    ]
}
