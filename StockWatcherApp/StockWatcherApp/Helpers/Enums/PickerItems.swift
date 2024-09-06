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
