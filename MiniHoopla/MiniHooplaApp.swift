//
//  MiniHooplaApp.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import SwiftUI

@main
struct MiniHooplaApp: App {
    
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MovieCollection()
                .environmentObject(appState)
        }
    }
}
