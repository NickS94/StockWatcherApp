//
//  NewCommentField.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 26.09.24.
//

import SwiftUI

struct NewCommentField: View {
    @ObservedObject var chatCommentsViewModel:ChatCommentsViewModel
    let socialChat:SocialChat
    var body: some View {
        HStack{
            TextField("Write a comment...", text: $chatCommentsViewModel.commentContent, axis: .vertical)
                .padding(8)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            Button{
                chatCommentsViewModel.fetchFireUser()
                chatCommentsViewModel.createNewComment(chat: socialChat)
                chatCommentsViewModel.commentContent = ""
                
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.title)
                    .foregroundStyle(.mainApp)
                    .padding(.horizontal,6)
            }
            .disabled( chatCommentsViewModel.commentContent == "")
        }
    }
}

#Preview {
    NewCommentField(chatCommentsViewModel: ChatCommentsViewModel(), socialChat: SocialChat(userId: "", publisherName: "Nick St", publisherProfileIcon: "", title: "Tesla", content: "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum .", likes: 20, dislikes: 12))
}
