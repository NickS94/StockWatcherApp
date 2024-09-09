//
//  LargeNumbersConversion.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import SwiftUI

enum NumberFormatterToString{
    
    static func formattedNumber(number: Int) -> String {
           
           var formattedValue: String {
               
               switch self {
                   
               case _ where number >= 1000000000000:
                   return "\(String(format: "%.2f", Double(number) / 1000000000000)) T."
                   
               case _ where number >= 1000000000:
                   return "\(String(format: "%.2f", Double(number) / 1000000000)) B."
                   
               case _ where number >= 1000000:
                   return "\(String(format: "%.2f", Double(number) / 1000000)) M."
                   
               default:
                   return "\(number)"
               }
           }
           
           return formattedValue
       }
}
