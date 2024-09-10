//
//  PickerItems.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import Foundation


enum HotListsPickerItems:String,CaseIterable{
    case mostActivelyTraded = "Most Traded"
    case gainers = "Gainers"
    case losers = "Losers"
    
}

enum DetailsViewPickerItems:String,CaseIterable{
    case profile = "Profile"
    case news = "News"
}

enum ChartTimeframes:String,CaseIterable{
    case oneMinute = "1min"
    case fiveMinutes = "5min"
    case fifthteenMinutes = "15min"
    case thirtyMinutes = "30min"
    case oneHour = "1hour"
    case fourHours = "4hour"
    
    var buttonLabels:String{
        switch self {
        case .oneMinute:
            "1m"
        case .fiveMinutes:
            "5m"
        case .fifthteenMinutes:
            "15m"
        case .thirtyMinutes:
            "30m"
        case .oneHour:
            "1H"
        case .fourHours:
            "4H"
        }
    }
}
