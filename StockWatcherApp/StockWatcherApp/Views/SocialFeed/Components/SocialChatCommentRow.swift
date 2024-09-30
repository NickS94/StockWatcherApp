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
                
                Text("@\(chatCommentViewModel.getFireUserUsername(chatComment: chatComment))")
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
                        chatCommentViewModel.onCommentLikeClicked(chatComment:chatComment,chatId:chatId)
                        chatCommentViewModel.isLiked = true
                        chatCommentViewModel.isDisliked = false
                    } label: {
                        Image(systemName: chatCommentViewModel.likeCheck(chatComment: chatComment) ? "hand.thumbsup.fill" : "hand.thumbsup")
                        Text("\(chatComment.likes)")
                    }
                    Divider()
                        .frame(width: 1,height: 20)
                        .background(.mainApp)
                    //Dislike button
                    Button{
                        chatCommentViewModel.onCommentDislikeClicked(chatComment: chatComment, chatId: chatId)
                        chatCommentViewModel.isDisliked = true
                        chatCommentViewModel.isLiked = false
                    } label: {
                        Image(systemName: chatCommentViewModel.dislikeCheck(chatComment: chatComment) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
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
            chatCommentViewModel.fetchCommentInteractions()
            chatCommentViewModel.fetchFireUsers()
        }
    }
}

#Preview {
    SocialChatCommentRow(chatComment:ChatComment(chatId: "", userId: "", publisherName: "NickS94", publisherProfileIcon: "", content: "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero," , likes: 2, dislikes: 1), chatId: "", chatCommentViewModel: ChatCommentsViewModel())
}
