//
//  HomeObserved.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 15.02.2025.
//

import SwiftUI

extension HomeView {
    @Observable final class Observed {
        var currentMaster: Master?
        var currentUser: Profile?
        var todaySlots = [TimeSlot]()
        var currentDate: Date = Date()
        
        init(userID: String = "j3IiQUYzAnV8rrLrsFmTYHmkrJG3", masterID: String = "xsQ5sxXtKKXdVl2Ch5phVdu2YNB2") {
            fetchData(userId: userID, masterID: masterID)
        }
        
        ///вызывается при нажатии на день и выдает слоты по этому дню
        func getTodaySlots() {
            guard let currentMaster else { return }
            todaySlots = currentMaster.slots.filter { slot in
                Date.compareDays(first: slot.date, second: currentDate)
            }
        }
        
        func fetchData(userId: String, masterID: String) {
            //Получение юзeра из Firestore
            Task {
                let profile = try await FirestoreService.shared.getProfile(id: userId)
                await MainActor.run {
                    self.currentUser = profile
                }
            }
            //Получение мастера, а потом его слотов
            Task {
                let master = try await FirestoreService.shared.getMaster(byId: masterID)
                await MainActor.run {
                    self.currentMaster = master
                }
                
                let slots = try await FirestoreService.shared.getSlotsbyMasterId(masterID)
                await MainActor.run {
                    self.currentMaster?.slots = slots
                }
            }
        }
        
        ///запись клиента
        func book(slot: TimeSlot, clientID: String) {
            Task {
                try await FirestoreService.shared.booking(timeSlot: slot, clientID: clientID)
                fetchData(userId: currentUser!.id, masterID: currentMaster!.id)
            }
        }
    }
    
}
