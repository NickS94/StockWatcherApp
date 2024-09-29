//
//  NewPostSheet.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.09.24.
//

import SwiftUI

struct NewPostSheet: View {
    @Binding var showNewPostSheet:Bool
    @ObservedObject var socialFeedViewModel:SocialFeedViewModel
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                TextField("Add Title", text: $socialFeedViewModel.chatTitle)
                    .font(.title.bold())
                
                TextField("What's on your mind?", text: $socialFeedViewModel.chatContent, axis: .vertical)
                    .font(.title2)
                Spacer()
            }
            .padding()
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        showNewPostSheet = false
                    }label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundStyle(.mainApp)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        socialFeedViewModel.createPost()
                        showNewPostSheet = false
                    }label: {
                        Image(systemName: "paperplane.fill")
                            .font(.title)
                            .foregroundStyle(.mainApp)
                            .padding(.horizontal,6)
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("New Post")
        }
    }
}

#Preview {
    NewPostSheet(showNewPostSheet: .constant(false), socialFeedViewModel: SocialFeedViewModel())
}
