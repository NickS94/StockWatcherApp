//
//  TickerChart.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 09.09.24.
//

import SwiftUI
import Charts

struct TickerChart: View {
    let chartTimeStampList:[ChartQuote]
    let lastClose:Double
    
    var body: some View {
        
        Chart {
            ForEach(chartTimeStampList,id:\.date) { chartQuote in
                
                LineMark(x: .value("Time", chartQuote.date), y:.value("Close", chartQuote.close))
                    .foregroundStyle(ChartLineColor.chartLineColor (lastClose: lastClose, chartQuoteList: chartTimeStampList))
                
                AreaMark(x: .value("Time", chartQuote.date), yStart: .value("Min",chartTimeStampList.map{$0.close}.min() ?? 0),yEnd: .value("Max", chartQuote.close))
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [
                            ChartLineColor.chartLineColor(lastClose: lastClose, chartQuoteList: chartTimeStampList)
                            ,.clear]),
                        startPoint: .top,
                        endPoint: .bottom))
                
            }
        }
        .frame(maxWidth: .infinity,maxHeight: 400)
        .chartYScale(domain: (chartTimeStampList.map{$0.close}.min() ?? 0)...(chartTimeStampList.map{$0.close}.max() ?? 0))
        .chartXAxis(.hidden)
    }
}
#Preview {
    TickerChart(chartTimeStampList: [ ChartQuote(date: "2023-09-08 09:30:00", open: 177.50, low: 177.50, high: 178.20, close: 178.90, volume: 1200000),
                                      ChartQuote(date: "2023-09-08 09:35:00", open: 177.80, low: 177.60, high: 178.00, close: 177.90, volume: 1500000),
                                      ChartQuote(date: "2023-09-08 09:40:00", open: 177.90, low: 177.50, high: 178.10, close: 177.70, volume: 1700000),
                                      ChartQuote(date: "2023-09-08 09:45:00", open: 177.70, low: 177.40, high: 178.00, close: 177.50, volume: 1800000),
                                      ChartQuote(date: "2023-09-08 09:50:00", open: 177.50, low: 177.40, high: 177.90, close: 177.60, volume: 1600000),
                                      ChartQuote(date: "2023-09-08 09:55:00", open: 177.60, low: 177.30, high: 177.80, close: 177.70, volume: 1400000),
                                      ChartQuote(date: "2023-09-08 10:00:00", open: 177.70, low: 177.50, high: 177.90, close: 177.80, volume: 1300000),
                                      ChartQuote(date: "2023-09-08 10:05:00", open: 177.80, low: 177.60, high: 178.00, close: 177.90, volume: 1100000),
                                      ChartQuote(date: "2023-09-08 10:10:00", open: 177.90, low: 177.70, high: 178.10, close: 177.80, volume: 1000000),
                                      ChartQuote(date: "2023-09-08 10:15:00", open: 177.80, low: 177.60, high: 178.00, close: 177.70, volume: 900000),
                                      ChartQuote(date: "2023-09-08 10:20:00", open: 177.70, low: 177.50, high: 177.90, close: 177.60, volume: 850000),
                                      ChartQuote(date: "2023-09-08 10:25:00", open: 177.60, low: 177.30, high: 177.80, close: 177.50, volume: 750000),
                                      ChartQuote(date: "2023-09-08 10:30:00", open: 177.50, low: 177.20, high: 177.70, close: 177.40, volume: 680000),
                                      ChartQuote(date: "2023-09-08 10:35:00", open: 177.40, low: 177.10, high: 177.60, close: 177.30, volume: 620000),
                                      ChartQuote(date: "2023-09-08 10:40:00", open: 177.30, low: 177.00, high: 177.50, close: 177.20, volume: 590000),
                                      ChartQuote(date: "2023-09-08 10:45:00", open: 177.20, low: 177.00, high: 177.40, close: 177.10, volume: 540000),
                                      ChartQuote(date: "2023-09-08 10:50:00", open: 177.10, low: 176.90, high: 177.30, close: 177.00, volume: 500000),
                                      ChartQuote(date: "2023-09-08 10:55:00", open: 177.00, low: 176.80, high: 177.20, close: 176.90, volume: 480000),
                                      ChartQuote(date: "2023-09-08 11:00:00", open: 176.90, low: 176.70, high: 177.10, close: 176.80, volume: 470000),
                                      ChartQuote(date: "2023-09-08 11:05:00", open: 176.80, low: 176.60, high: 177.00, close: 176.70, volume: 460000),
                                      ChartQuote(date: "2023-09-08 11:10:00", open: 176.70, low: 176.50, high: 176.90, close: 176.60, volume: 440000),
                                      ChartQuote(date: "2023-09-08 11:15:00", open: 176.60, low: 176.40, high: 176.80, close: 176.50, volume: 430000),
                                      ChartQuote(date: "2023-09-08 11:20:00", open: 176.50, low: 176.30, high: 176.70, close: 177.55, volume: 420000),
                                      ChartQuote(date: "2023-09-08 11:25:00", open: 176.40, low: 176.20, high: 176.60, close: 176.30, volume: 410000)], lastClose: 168.5)
}
