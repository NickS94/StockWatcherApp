//
//  TickerAvQuoteRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI

struct TickerAvQuoteRow: View {
    
    let tickerQuoteAv:TickerQuoteAv
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: ImageUrls.fmpTickerImage(ticker:tickerQuoteAv.ticker).urlString)){ image in
                ZStack(alignment:.center){
                    Rectangle()
                        .frame(width: 48,height: 48)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.gray.opacity(0.5))
                    image
                        .resizable()
                        .frame(width: 36,height: 36)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                }
                
            }placeholder: {
                ProgressView()
            }
            
            VStack(alignment:.leading,spacing: 8){
                Text(tickerQuoteAv.ticker)
                    .monospacedStyle(size: 16, weight: .bold)
               
            }
            
            Spacer()
            
            VStack(alignment:.trailing,spacing: 8){
                Text(String(tickerQuoteAv.price)+"$")
                    .monospacedStyle(size: 14, weight: .semibold)
                
                HStack {
                    
                    Text(tickerQuoteAv.changeAmount)
                        .monospacedStyle(size: 12, weight: .regular)
                        .colouredValuesStrings(input: tickerQuoteAv.changeAmount)
                    
                    Text("(\(tickerQuoteAv.changePercentage))")
                        .monospacedStyle(size: 12, weight: .regular)
                        .colouredValuesStrings(input: tickerQuoteAv.changePercentage)
                }
            }
        }
        .padding()
        Divider()
    }
}
    


//#Preview {
//    TickerAvQuoteRow(tickerQuoteAv: TickerQuoteAv(ticker: "NKLA", price: "215.0", change_amount: "1.40", change_percentage: "0.82%", volume: "2039035"))
//}
