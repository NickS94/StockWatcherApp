//
//  MonospacedStyle.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 28.08.24.
//

import SwiftUI


struct MonospacedStyle:ViewModifier{
    
    let size:CGFloat
    let weight:Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size,weight: weight,design: .monospaced))
            
    }
    
}

extension View {
    func monospacedStyle(size:CGFloat,weight:Font.Weight) -> some View {
        self.modifier(MonospacedStyle(size: size, weight: weight))
    }
}

