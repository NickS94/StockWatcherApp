//
//  MonospacedStyle.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI

//Modifier for the text style.
struct RoundedStyle:ViewModifier{
    
    let size:CGFloat
    let weight:Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size,weight: weight,design: .rounded))
    }
}

extension View {
    func roundedStyle(size:CGFloat,weight:Font.Weight) -> some View {
        self.modifier(RoundedStyle(size: size, weight: weight))
    }
}

