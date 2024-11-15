//
//  DateFormatter.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import Foundation
// Formatting how the Date is viewed as string.
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

extension String{
    var toDate:Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"
     
        if let date = dateFormatter.date(from: self){
          return date
        }
        return nil
    }
    
}
