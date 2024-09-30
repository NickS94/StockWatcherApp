//
//  GaugeTintByValue.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 06.09.24.
//

import SwiftUI

// This modifier is for the GaugeViews in the TickerDetailsView.
struct GaugeTintByValue:ViewModifier{
    let minValue:Double
    let maxValue:Double
    let currentValue:Double
    
    var color:Color{
        switch averagePrice(){
            
        case true:
                .green
        case false:
                .red
        }
    }
    
    func body(content: Content) -> some View {
        
        content
            .tint(color)
    }
    
    
    private func averagePrice()->Bool{
        
        let average = (minValue + maxValue) / 2
        
        return average < currentValue
    }
    
}

extension View{
    func gaugeTintByValue(_ minValue:Double,_ maxValue:Double,_ currentValue:Double)-> some View{
        modifier(GaugeTintByValue(minValue: minValue, maxValue: maxValue, currentValue: currentValue))
    }
}
