//
//  WeekView.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 18.01.2025.
//

import SwiftUI

struct WeekView: View {
    
    var week: [Date.WeekDay]
    @Binding var currentDate: Date
    @Binding var showWeek: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(week) { weekDay in
                VStack(spacing: 8) {
                    Text(weekDay.date.format(dateFormat: "E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    Text(weekDay.date.format(dateFormat: "dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(weekDay.date, currentDate) ? .white : .gray)
                        .frame(width: 36, height: 36)
                        .background {
                            if isSameDate(weekDay.date, currentDate) {
                                Circle().fill(Color.selectedDate)
                            }
                            if weekDay.date.isToday {
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 6, height: 6, alignment: .bottom)
                                    .offset(y: 30)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                currentDate = weekDay.date
                            }
                        }
                }
                .horizontalExpand()
            }
        }
    }
}

#Preview {
    WeekView(week: [.init(date: Date())], currentDate: .constant(Date.now), showWeek: .constant(true))
}
