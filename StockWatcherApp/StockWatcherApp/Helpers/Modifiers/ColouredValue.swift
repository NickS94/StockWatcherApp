//
//  ColouredValue.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI

struct ColouredValue:ViewModifier{
    
    let value:Double
    
    var color: Color {
            switch value {
            case _ where value < 0:
                return .red
            case _ where value > 0:
                return .green
            default:
                return .gray
            }
        }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
    }
}

extension View{
    func colouredValue(value:Double) -> some View{
        self.modifier(ColouredValue(value: value))
    }
}
