//
//  SocialChatCommentRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 25.09.24.
//

import SwiftUI

struct SocialChatCommentRow: View {
    let chatComment:ChatComment
    let chatId:String
    @State var isLiked = false
    @State var isDisliked = false
    @ObservedObject var chatCommentViewModel:ChatCommentsViewModel
    var body: some View {
        VStack(alignment:.leading,spacing:20){
            HStack(spacing:15){
                AsyncImage(url: URL(string: chatCommentViewModel.getFireUserProfileIcon(chatComment: chatComment))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36,height:36)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 0.3)
                                .frame(width: 42,height: 42)
                        }
                } placeholder: {
                    Image(systemName: chatCommentViewModel.getFireUserProfileIcon(chatComment: chatComment))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36,height:36)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 0.3)
                                .frame(width: 42,height: 42)
                        }
                }
                
                Text("@\(chatComment.publisherName)")
                    .font(.footnote)
                Spacer()
                Text(chatComment.createdAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.footnote)

            }
            
            Text(chatComment.content)
                .roundedStyle(size: 16, weight: .regular)
               
            HStack{
                //Like button
                HStack(spacing:20) {
                    Button {
                        Task{
                            await chatCommentViewModel.onCommentLikeClicked(chatComment:chatComment,chatId:chatId)
                            
                            let result = chatCommentViewModel.commentInteractionCheck(commentId: chatComment.id)
                            guard result.isEmpty else{
                                isLiked = result[0].isLiked
                                isDisliked = result[0].isDisliked
                                return
                            }
                            isLiked = false
                            isDisliked = false
                        }
                    } label: {
                        Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        Text("\(chatComment.likes)")
                    }
                    Divider()
                        .frame(width: 1,height: 20)
                        .background(.mainApp)
                    //Dislike button
                    Button{
                        Task{
                            await chatCommentViewModel.onCommentDislikeClicked(chatComment: chatComment, chatId: chatId)
                            let result = chatCommentViewModel.commentInteractionCheck(commentId: chatComment.id)
                            guard result.isEmpty else{
                                isDisliked = result[0].isDisliked
                                isLiked = result[0].isLiked
                                return
                            }
                            isLiked = false
                            isDisliked = false
                        }
                    } label: {
                        Image(systemName: isDisliked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        Text("\(chatComment.dislikes)")
                    }
                }
                .padding(.vertical,7)
                .padding(.horizontal,10)
                .overlay {
                    Capsule()
                        .stroke(lineWidth: 0.8)
                }
            }
            .tint(.mainApp)
            
            Divider()
                .frame(height: 0.6)
                .background(.mainApp)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .onAppear{
            let result = chatCommentViewModel.commentInteractionCheck(commentId: chatComment.id)
            guard result.isEmpty else{
                isLiked = result[0].isLiked
                isDisliked = result[0].isDisliked
                return
            }
            chatCommentViewModel.fetchFireUsers()
            chatCommentViewModel.fetchFireUser()
        }
    }
}

#Preview {
    SocialChatCommentRow(chatComment:ChatComment(chatId: "", userId: "", publisherName: "NickS94", publisherProfileIcon: "", content: "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero," , likes: 2, dislikes: 1), chatId: "", chatCommentViewModel: ChatCommentsViewModel())
}
