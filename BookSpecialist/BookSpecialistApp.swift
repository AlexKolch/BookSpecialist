//
//  BookSpecialistApp.swift
//  BookSpecialist
//
//  Created by Алексей Колыченков on 18.01.2025.
//

import SwiftUI

@main
struct BookSpecialistApp: App {
    var body: some Scene {
        WindowGroup {
            RouteView()
                .preferredColorScheme(.light)
        }
    }
}
