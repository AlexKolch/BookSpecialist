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
        var timeslot: Timeslot
        
        var timeLabel: String {
            "\(self.timeslot.date.formatted(date: .omitted, time: .shortened)) - \(self.timeslot.endDate.formatted(date: .omitted, time: .shortened))"
        }
        
        var isAvailableDescription: String {
            guard timeslot.clientId != nil else {
                return "Время свободно!"
            }
            
            if timeslot.clientId == Timeslot.mockUserId {
                return "Вы записаны на это время!"
            }
            return "Время занято"
        }
        
        var bgColor: Color {
            if timeslot.clientId == nil {
                return .greenBG
            }
            return timeslot.clientId == Timeslot.mockUserId ? .yellowBG : .redBG
        }
        
        init(timeslot: Timeslot) {
            self.timeslot = timeslot
        }
    }
    
}

#Preview {
    TimeSlot_Cell(observed: .init(timeslot:
            .init(masterId: Timeslot.mockMasterId, date: .now)))
}
