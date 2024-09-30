//
//  EmptyCommentSection.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.09.24.
//

import SwiftUI

struct EmptyViewWithText: View {
    let text:String
    var body: some View {
        VStack{
            Image(systemName: "ellipses.bubble.fill")
                .font(.system(size: 100))
            Text(text)
                .roundedStyle(size: 20, weight: .semibold)
        }
        .padding(.vertical,50)
    }
}

#Preview {
    EmptyViewWithText(text: "Be the first to comment this post..")
}
