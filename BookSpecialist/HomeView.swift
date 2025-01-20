//
//  HomeView.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 18.01.2025.
//

import SwiftUI

struct HomeView: View {
    //MARK: Week properties
    @State private var currentDate: Date = Date()
    @State private var currentWeekIndex: Int = 1
    @State private var showWeek: Bool = true
    @State private var weekData: [[Date.WeekDay]] = []
    
    //MARK: Week properties
    @Namespace private var animation
    @State private var showApproveView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            ScrollView {
                
            }
        }
        .onAppear {
            let currentWeek = Date().fetchWeekDays()
            if let firstDate = currentWeek.first?.date {
                //получаем предыдущую неделю
                weekData.append(firstDate.fetchPreviousWeekDays())
            }
            weekData.append(currentWeek) //настоящая
            if let lastDate = currentWeek.last?.date {
                weekData.append(lastDate.fetchNextWeekDays()) //будущая
            }
        }
    }
    
    @ViewBuilder func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            mainDateInfo
        
            fullDateInfo
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekData.indices, id: \.self) { index in
                    WeekView(week: weekData[index], currentDate: $currentDate, showWeek: $showWeek)
                }
                .background {
                    GeometryReader { proxy in
                        let minX: CGFloat = proxy.frame(in: .global).minX
                        
                        Color.clear
                            .preference(key: OffsetKey.self, value: minX)
                            .onPreferenceChange(OffsetKey.self) { value in
                                if value.rounded() == 15 && showWeek {
                                    leafPagWeek()
                                }
                            }
                    }
                }
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
        }
        .padding()
    }
    
    func leafPagWeek() {
        if weekData.indices.contains(currentWeekIndex) {
            if let firstDate = weekData[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekData.insert(firstDate.fetchPreviousWeekDays(), at: 0)
                weekData.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekData[currentWeekIndex].last?.date, currentWeekIndex == weekData.count - 1 {
                weekData.append(lastDate.fetchNextWeekDays())
                currentWeekIndex = weekData.count - 2
            }
        }
    }
    
}

#Preview {
    HomeView()
}

private extension HomeView {
    
    var fullDateInfo: some View {
        Text(currentDate.formatted(date: .complete, time: .omitted))
            .font(.callout.weight(.semibold))
            .textScale(.secondary)
            .foregroundStyle(.gray)
    }
    
    var mainDateInfo: some View {
        HStack(spacing: 5) {
            Text(currentDate.format(dateFormat: "MMMM"))
                .foregroundStyle(Color(uiColor: UIColor.systemBlue))
            Text(currentDate.format(dateFormat: "yyyy"))
                .foregroundStyle(.gray)
        }
        .font(.title.bold())
    }
}
