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
    case thirtyMinutes = "30min"
    case fifthteenMinutes = "15min"
    case oneHour = "1hour"
    case fourHours = "4hour"
    
    var buttonLabels:String{
        switch self {
        case .oneMinute:
            "1D"
        case .fiveMinutes:
            "1W"
        case .thirtyMinutes:
            "1M"
        case .fifthteenMinutes:
            "3M"
        case .oneHour:
            "4M"
        case .fourHours:
            "6M"
        }
    }
}

enum ProfileIcons:String,CaseIterable{

    case cat
    case dog
    case bug
    case ant
    case fish
    case lizard
    case hare
    case tortoise
    case bird
    case paw
    case teddybear
    
    var iconName:String{
        switch self {
        case .cat:
            "cat.fill"
        case .dog:
            "dog.fill"
        case .bug:
            "ladybug.fill"
        case .ant:
            "ant.fill"
        case .fish:
            "fish.fill"
        case .lizard:
            "lizard.fill"
        case .hare:
            "hare.fill"
        case .tortoise:
            "tortoise.fill"
        case .bird:
            "bird.fill"
        case .paw:
            "pawprint.fill"
        case .teddybear:
            "teddybear.fill"
        }
    }    
}
