//
//  TimeSlot_Cell.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 26.01.2025.
//

import SwiftUI

struct TimeSlot_Cell: View {
    
    @State var observed: Observed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.0) {
            Text(observed.timeLabel)
                .font(.title2.bold())
            Text(observed.isAvailableDescription)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 19)
        .padding(.vertical, 12)
        .background(observed.bgColor)
        .clipShape(.rect(cornerRadius: 14))
        .offset(x: 42)
    }
}

extension TimeSlot_Cell {
    
    @Observable
    class Observed {
        var timeslot: TimeSlot
        
        var timeLabel: String {
            "\(self.timeslot.date.formatted(date: .omitted, time: .shortened)) - \(self.timeslot.endDate.formatted(date: .omitted, time: .shortened))"
        }
        
        var isAvailableDescription: String {
            guard timeslot.clientId != nil else {
                return "Время свободно!"
            }
            
            if timeslot.clientId == TimeSlot.mockUserId {
                return "Вы записаны на это время!"
            }
            return "Время занято"
        }
        
        var bgColor: Color {
            if timeslot.clientId == nil {
                return .greenBG
            }
            return timeslot.clientId == TimeSlot.mockUserId ? .yellowBG : .redBG
        }
        
        init(timeslot: TimeSlot) {
            self.timeslot = timeslot
        }
    }
    
}

#Preview {
    TimeSlot_Cell(observed: .init(timeslot:
            .init(masterId: TimeSlot.mockMasterId, date: .now)))
}
