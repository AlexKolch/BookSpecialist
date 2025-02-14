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
    @State private var showProfileView: Bool = false
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    
    //MARK: Week properties
    @Namespace private var animation
    @State private var showApproveView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //MARK: Header
            HeaderView()
            //MARK: TimesSlots
            ScrollView {
                VStack(spacing: 19.0) {
                    ForEach(Timeslot.mackdata) { slot in
                        TimeSlot_Cell(observed: .init(timeslot: slot))
                    }
                }
            }
            .background(.white)
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
        .overlay {
            if showProfileView {
                Rectangle()
                    .fill(.black.opacity(0.78))
                    .ignoresSafeArea()
                    .onTapGesture {
                        showProfileView = false
                    }
            }
        }
        .overlay {
            VStack(spacing: 45) {
                VStack(spacing: 27) {
                    TextField("Ваше имя", text: $name)
                        .padding(.top, 109)
                        .font(.title.bold())
                        .padding(.bottom, -16) //компенсируем spacing, поднимая нижний отступ
                    LeafTextField(isSecure: false, placeholder: "Ваш телефон", text: $phoneNumber)
                    Text("Ближайшие записи:").font(.caption.bold()).padding(.bottom, -16)
                    TabView {
                        
                    }
                    .frame(height: 75)
                    .background(.greenBG)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .tabViewStyle(.page)
                    .tint(.selectedDate)
                    LeafButton(title: "История записей") {
                        //TODO
                    }
                }
                .padding(.horizontal, 37)
                .padding(.bottom, 40)
                .background(.white)
                .clipShape(.rect(cornerRadii: .init(topLeading: 24, bottomLeading: 0, bottomTrailing: 48, topTrailing: 80)))
                .overlay(alignment: .top) {
                    Image(.avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 164, height: 164)
//                        .clipShape(.circle)
                        .padding(11)
                        .background(Circle().fill(.white))
                        .offset(y: -93)
                }
                .padding(.horizontal, 21) //прозрачный отступ относительно краев экрана
                
                Button("Выйти из аккаунта") {
                    //TODO
                }.foregroundStyle(.red)
            }
            .offset(y: showProfileView ? 0 : 1000)
            .animation(.easeInOut, value: showProfileView)
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
        .background(.white)
        .overlay(alignment: .topTrailing) {
            Image(.avatar)
                .resizable()
                .frame(width: 62, height: 62)
                .scaledToFill()
                .offset(x: -19)
                .onTapGesture {
                    showProfileView = true
                }
        }
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
            .foregroundStyle(.numberDate)
    }
    
    var mainDateInfo: some View {
        HStack(spacing: 5) {
            Text(currentDate.format(dateFormat: "MMMM"))
                .foregroundStyle(Color(uiColor: .systemOrange))
            Text(currentDate.format(dateFormat: "yyyy"))
                .foregroundStyle(.gray)
        }
        .font(.title.bold())
    }
}
