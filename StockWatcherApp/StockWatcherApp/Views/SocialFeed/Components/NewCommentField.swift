//
//  NewCommentField.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.09.24.
//

import SwiftUI

struct NewCommentField: View {
    @Binding var commentContent:String
    
    var body: some View {
        HStack{
            TextField("Write a comment...", text: $commentContent, axis: .vertical)
                .padding(8)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            Button{
                // TODO: Send comment button
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.title)
                    .foregroundStyle(.mainApp)
                    .padding(.horizontal,6)
            }
        }
    }
}

#Preview {
    NewCommentField(commentContent: .constant(""))
}
