//
//  CompanyInfo.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 03.09.24.
//

import SwiftUI

struct GeneralInformation: View {
    let tickerProfile:TickerProfile
    @ObservedObject var tickerProfileViewModel:TickerProfileViewModel
    @Binding var showFullDescription :Bool
    @Binding var lineLimit :Int
    var body: some View {
        ScrollView{
            
            VStack(alignment:.leading,spacing: 15){
                Text("About the company")
                    .font(.title2.bold())
                Text(tickerProfile.description ?? "")
                    .monospacedStyle(size: 14, weight: .regular)
                    .lineLimit(lineLimit)
                
                Text(showFullDescription ? "Read less" : "Read more")
                    .underline()
                    .onTapGesture {
                        showFullDescription.toggle()
                        
                        if showFullDescription {
                            lineLimit = 200
                        }else{
                            lineLimit = 6
                        }
                    }
                VStack{
                    ForEach(tickerProfileViewModel.generateInformationTable(tickerProfile: tickerProfile),id:\.0) { label,info  in
                        HStack{
                            Text(label)
                                .monospacedStyle(size: 12, weight: .regular)
                                .foregroundStyle(.gray)
                            Spacer()
                            Text(info)
                                .monospacedStyle(size: 14, weight: .regular)
                           Divider()
                        }
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    GeneralInformation(tickerProfile: TickerProfile(
        symbol: "AAPL",
        price: 230.28,
        beta: 1.244,
        volAvg: 63839122,
        lastDiv: 1.0,
        range: "164.08-237.23",
        changes: 0.49,
        companyName: "Apple Inc.",
        currency: "USD",
        cik: "0000320193",
        isin: "US0378331005",
        cusip: "037833100",
        exchange: "NASDAQ Global Select",
        exchangeShortName: "NASDAQ",
        industry: "Consumer Electronics",
        website: "https://www.apple.com",
        description: """
        Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide.
        The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and
        wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, and HomePod. It also provides
        AppleCare support and cloud services; and operates various platforms, including the App Store that allow customers to discover
        and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers
        various services, such as Apple Arcade, a game subscription service; Apple Fitness+, a personalized fitness service; Apple Music,
        which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine
        service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless
        payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses;
        and the education, enterprise, and government markets. It distributes third-party applications for its products through the App
        Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular
        network carriers, wholesalers, retailers, and resellers. Apple Inc. was incorporated in 1977 and is headquartered in Cupertino,
        California.
        """,
        ceo: "Mr. Timothy D. Cook",
        sector: "Technology",
        country: "US",
        fullTimeEmployees: "161000",
        phone: "408 996 1010",
        address: "One Apple Park Way",
        city: "Cupertino",
        state: "CA",
        zip: "95014",
        dcfDiff: 72.75592,
        dcf: 159.2440770263711,
        image: "https://financialmodelingprep.com/image-stock/AAPL.png",
        ipoDate: "1980-12-12"), tickerProfileViewModel: TickerProfileViewModel(repository: MockRepository()),showFullDescription:.constant(false),lineLimit: .constant(6))
}
