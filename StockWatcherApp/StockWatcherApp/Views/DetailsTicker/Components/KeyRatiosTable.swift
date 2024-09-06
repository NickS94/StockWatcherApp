//
//  KeyRatiosTable.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import SwiftUI

struct KeyRatiosTable: View {
    let dividend:Double
    let beta:Double
    @ObservedObject var detailsViewModel:DetailsViewModel
    
    
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            Text("Key Ratios")
                .font(.title2.bold())
                .padding(.bottom)
            
            ForEach(detailsViewModel.generateTickerKeyRatios(divident: dividend,beta: beta),id: \.0){ label , value in
                HStack{
                    Text(label)
                        .monospacedStyle(size: 14, weight: .regular)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("\(NumberFormatterToString.formattedNumber(number:Int(value)))")
                        .monospacedStyle(size: 16, weight: .regular)
                    
                }
            }
        }
    }
}


#Preview {
    KeyRatiosTable(dividend: 2,beta: 6 , detailsViewModel: DetailsViewModel(repository: MockRepository()))
}
