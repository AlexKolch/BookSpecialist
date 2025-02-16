//
//  Master.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 15.02.2025.
//

import Foundation


final class Master: Identifiable {
    let id: String
    var name: String
    var slots: [TimeSlot] = [] //слоты добавляются в HomeObserved
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
    
    ///failable init для создания мастера из Firebase
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String else { return nil }
       
        self.id = id
        self.name = name
    }
}



