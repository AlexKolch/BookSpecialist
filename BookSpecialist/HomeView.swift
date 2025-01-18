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
                    WeekView(week: weekData[index], currentDate: $currentDate)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
        }
        .padding()
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
