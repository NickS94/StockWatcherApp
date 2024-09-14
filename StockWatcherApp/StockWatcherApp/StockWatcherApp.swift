//
//  StockWatcherAppApp.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.08.24.
//

import SwiftUI
import Firebase

@main
struct StockWatcherApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Firebase configured")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
