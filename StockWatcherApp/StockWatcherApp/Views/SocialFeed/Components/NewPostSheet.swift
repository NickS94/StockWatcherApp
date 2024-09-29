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
            VStack(alignment:.leading,spacing: 30){
                HStack(alignment:.center){
                    AsyncImage(url: socialFeedViewModel.user?.photoURL){ image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45,height:45)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 0.3)
                                    .frame(width: 52,height: 52)
                            }
                    }placeholder: {
                        Image(systemName: socialFeedViewModel.fireuser?.userProfileIcon ?? "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45,height:45)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 0.3)
                                    .frame(width: 52,height: 52)
                            }
                    }
                    .padding(.vertical)
                    
                    
                    VStack(alignment:.leading){
                        Text("@\(socialFeedViewModel.fireuser?.username ?? "NoName")")
                            .font(.title3.bold())
                    }
                }
                TextField("Add Title", text: $socialFeedViewModel.chatTitle)
                    .font(.title.bold())
                
                TextField("What's on your mind?", text: $socialFeedViewModel.chatContent, axis: .vertical)
                    .font(.title2.italic())
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
            .onAppear {
                socialFeedViewModel.fetchFireUser()
            }
        }
    }
}

#Preview {
    NewPostSheet(showNewPostSheet: .constant(false), socialFeedViewModel: SocialFeedViewModel())
}
