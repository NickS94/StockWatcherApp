//
//  ColouredValuesStrings.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 29.08.24.
//

import SwiftUI
//This modifier is to color the string text.
struct ColouredValuesStrings:ViewModifier{
    
    let input:String
    
    
    var color: Color {
            switch input {
            case _ where input.contains("-"):
                return .red
            default:
                return .green
            }
        }
    func body(content: Content) -> some View {
       content
            .foregroundStyle(color)
        
    }
}

extension View {
    func colouredValuesStrings(input:String) -> some View{
        modifier(ColouredValuesStrings(input: input))
    }
}
