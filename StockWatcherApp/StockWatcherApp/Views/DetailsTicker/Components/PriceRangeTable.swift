//
//  PriceRangeTable.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import SwiftUI

struct PriceRangeTable: View {
    let tickerQuote:TickerQuote
    var body: some View {
        VStack(spacing: 50){
            Group{
                Gauge(value:tickerQuote.price ?? 0, in: (tickerQuote.dayLow ?? 0)...(tickerQuote.dayHigh ?? 0)){
                    Text("Today's Range")
                        .padding()
                } currentValueLabel: {
                    Text("")
                } minimumValueLabel: {
                    Text(String(tickerQuote.dayLow ?? 0))
                } maximumValueLabel: {
                    Text(String(tickerQuote.dayHigh ?? 0))
                }
                .gaugeTintByValue(tickerQuote.dayLow ?? 0, tickerQuote.dayHigh ?? 0, tickerQuote.price ?? 0)
                
                Gauge(value: tickerQuote.price ?? 0, in: (tickerQuote.yearLow ?? 0)...(tickerQuote.yearHigh ?? 0)){
                        Text("Year's Range")
                        .padding()
                }currentValueLabel: {
                    Text("")
                }minimumValueLabel: {
                        Text(String(tickerQuote.yearLow ?? 0))
                }maximumValueLabel: {
                        Text(String(tickerQuote.yearHigh ?? 0))
                }
                .gaugeTintByValue(tickerQuote.yearLow ?? 0, tickerQuote.yearHigh ?? 0, tickerQuote.price ?? 0)
                
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .monospacedStyle(size: 14, weight: .semibold)
        }
    }
}

#Preview {
    PriceRangeTable(tickerQuote: TickerQuote(
        symbol: "AAPL",
        name: "Apple Inc.",
        price: 229.30,
        changesPercentage: 0.0783,
        change: 0.18,
        dayLow: 199.5,
        dayHigh: 285.3,
        yearHigh: 237.23,
        yearLow: 164.08,
        marketCap: 3496486877000,
        priceAvg50: 221.2112,
        priceAvg200: 193.88576,
        exchange: "NASDAQ",
        eps: 6.57,
        pe: 35,
        sharesOutstanding: 15204100000
    ))
}
