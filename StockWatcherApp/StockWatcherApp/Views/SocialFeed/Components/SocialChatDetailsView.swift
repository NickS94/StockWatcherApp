//
//  SocialChatDetailsView.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import SwiftUI

struct SocialChatDetailsView: View {
    let socialChat:SocialChat
    @ObservedObject var socialFeedViewModel:SocialFeedViewModel
    @StateObject var chatCommentsViewModel = ChatCommentsViewModel()
    var body: some View {
        ScrollView{
            VStack{
                
                SocialChatRow(socialChat: socialChat, socialFeedViewModel: socialFeedViewModel)
                
                NewCommentField(commentContent: $chatCommentsViewModel.commentContent)
                
                if chatCommentsViewModel.chatComments.isEmpty{
                    EmptyViewWithText(text: "Be the first to comment this post..")
                }else{
                    ForEach(chatCommentsViewModel.chatComments) { comment in
                        SocialChatCommentRow(chatComment: comment)
                    }
                }
            }
        }
        .navigationTitle(socialChat.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    SocialChatDetailsView(socialChat: SocialChat(userId: "", publisherName: "Nick St", publisherProfileIcon: URL(string: "https://financialmodelingprep.com/image-stock/TSLA.png"), title: "Tesla", content: "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum .", likes: 20, dislikes: 12), socialFeedViewModel: SocialFeedViewModel())
//}
