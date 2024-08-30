//
//  TickerRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI

struct TickerQuoteRow: View {
    let tickerQuote:TickerQuote
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: ImageUrls.fmpTickerImage(ticker:tickerQuote.symbol).urlString)){ image in
                ZStack(alignment:.center){
                    Rectangle()
                        .frame(width: 48,height: 48)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.blue.opacity(0.5))
                    image
                        .resizable()
                        .frame(width: 24,height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                }
                
            }placeholder: {
                ProgressView()
            }
            
            VStack(alignment:.leading,spacing: 8){
                Text(tickerQuote.symbol)
                    .monospacedStyle(size: 16, weight: .bold)
                Text(tickerQuote.name.prefix(12))
                    .monospacedStyle(size: 12, weight: .light)
            }
            
            Spacer()
            
            VStack(alignment:.trailing,spacing: 8){
                Text(String(tickerQuote.price)+"$")
                    .monospacedStyle(size: 14, weight: .semibold)
                
                HStack {
                    Text(String(format: "%.2f", tickerQuote.change))
                        .monospacedStyle(size: 12, weight: .regular)
                        .colouredValue(value: tickerQuote.change)
                    Text("(\(String(tickerQuote.changesPercentage))%)")
                        .monospacedStyle(size: 12, weight: .regular)
                        .colouredValue(value: tickerQuote.changesPercentage)
                }
            }
        }
        .padding()
        Divider()
    }
}

#Preview {
    TickerQuoteRow(tickerQuote: TickerQuote(symbol: "AAPL", name: "Apple Inc.", price: 197.54, changesPercentage: 0.43, change: 0.1))
}
