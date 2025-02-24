//
//  ContentView.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 18.01.2025.
//

import SwiftUI

enum AppState {
    case authorized
    case unAuthorized
}

struct RouteView: View {
    
    @State private var observed = Observed()
    
    //Направляем сост приложения на аутентификацию, либо на домашний экран
    var body: some View {
        if observed.appState == .unAuthorized {
            AuthView(routeObserved: observed)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(colors: [.lightGradient, .darkGradient], startPoint: .topLeading, endPoint: .bottomTrailing))
        } else {
            HomeView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.grayBG)
        }
    }
}

extension RouteView {
    
    @Observable
    class Observed {
        var appState: AppState = .unAuthorized
    }
    
}

#Preview {
    RouteView()
}
