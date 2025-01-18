//
//  Date + Ext..swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 18.01.2025.
//

import Foundation

extension Date {
    ///совпадение текущего дня
    var isToday: Bool { Calendar.current.isDateInToday(self) }
    ///совпадение текущего часа
    var isSameHour: Bool { Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame }
    
    var isPassed: Bool { Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending }
    var isFuture: Bool { !isPassed }
    
    ///Date -> String
    func format(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    ///Получить текущую неделю
    func fetchWeekDays(_ date: Date = Date()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date) //получаем стартовую дату отсчета от которой будем получать неделю
        var weekDays = [WeekDay]()
        let weekOfDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        //получаем начало недели
        guard let startOfWeek = weekOfDate?.start else { return weekDays }
        
        (0..<7).forEach { index in
            //создаем день недели
            if let weekOfDate = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                weekDays.append(WeekDay(date: weekOfDate)) //получаем 7 дней недели
            }
        }
        
        return weekDays
    }
    
    func fetchNextWeekDays() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfDate) else { return [] }
        return fetchWeekDays(nextDate)
    }
    
    func fetchPreviousWeekDays() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfDate) else { return [] }
        return fetchWeekDays(previousDate)
    }
    
    struct WeekDay: Identifiable {
        let id: UUID = UUID()
        let date: Date
    }
    
}
