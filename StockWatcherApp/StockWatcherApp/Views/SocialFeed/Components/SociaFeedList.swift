//
//  SociaFeedList.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import SwiftUI

struct SociaFeedList: View {
    @ObservedObject var socialFeedViewModel:SocialFeedViewModel
    @Binding var showNewPostSheet:Bool
    var body: some View {
        VStack{
            HStack{
                Text("Social Feed")
                    .roundedStyle(size: 22, weight: .bold)
                Spacer()
                Button {
                    showNewPostSheet = true
                } label: {
                    HStack{
                        Text("New Post")
                            .roundedStyle(size: 14, weight: .semibold)
                            .foregroundStyle(.mainApp)
                        Image(systemName: "plus")
                            .font(.title.bold())
                            .foregroundStyle(.mainApp)
                            .padding(5)
                            .background(.gray.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
            }
            if socialFeedViewModel.socialChatList.isEmpty{
                EmptyViewWithText(text: "No posts yet")
            }else{
                ForEach(socialFeedViewModel.socialChatList){ chat in
                    NavigationLink {
                        SocialChatDetailsView(socialChat: chat, socialFeedViewModel: socialFeedViewModel)
                    } label: {
                        SocialChatRow(socialChat: chat, socialFeedViewModel: socialFeedViewModel)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    SociaFeedList(socialFeedViewModel: SocialFeedViewModel(), showNewPostSheet: .constant(false))
}
