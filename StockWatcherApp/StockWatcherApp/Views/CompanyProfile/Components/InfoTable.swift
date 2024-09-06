//
//  InforTable.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import SwiftUI

struct InfoTable: View {
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    var body: some View {
        VStack{
            ForEach(tickerProfileViewModel.generateInformationTable(),id:\.0) { label,info  in
                HStack{
                    Text(label)
                        .monospacedStyle(size: 14, weight: .regular)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(info)
                        .monospacedStyle(size: 14, weight: .regular)
                   Divider()
                }
            }
        }
        .padding()
    }
}

#Preview {
    InfoTable(tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()))
}
