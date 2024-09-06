//
//  DateFormatter.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import Foundation

enum DateFormatterHelper {
    static func formattedDate(from dateString: String?, with format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        guard let dateString = dateString else {
            return "Unknown Date"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}
