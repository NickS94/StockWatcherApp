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
    //App delegate used for the firebase functions 
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
          AuthenticationView()
        }
    }    
}
