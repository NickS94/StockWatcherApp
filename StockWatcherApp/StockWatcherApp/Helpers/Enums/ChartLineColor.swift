//
//  ChartLineColor.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 09.09.24.
//

import SwiftUI

//A modifier for the ChartLineColor.
enum ChartLineColor{
 
   static func chartLineColor(lastClose:Double,chartQuoteList:[ChartQuote]) ->Color{
        let lastChartPrice = chartQuoteList.last?.close
        
        if let lastChartPrice = lastChartPrice{
            if lastClose > lastChartPrice{
                return .red
            }else if lastChartPrice > lastClose{
                return .green
            }
        }
        return .gray
    }
}
