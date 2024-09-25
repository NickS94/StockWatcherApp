//
//  SocialChatRow.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 24.09.24.
//

import SwiftUI

struct SocialChatRow: View {
    
    let socialChat:SocialChat
    
    var body: some View {
        VStack(alignment:.leading){
            
            HStack (alignment:.bottom,spacing: 10){
                AsyncImage(url: socialChat.publisherProfileIcon) { image in
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
                } placeholder: {
                    Image(systemName: "person.fill")
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
                VStack(alignment:.leading){
                    Text("@\(socialChat.publisherName)")
                    Text(socialChat.createdAt.formatted(date: .abbreviated, time: .shortened))
                }
                
            }
            .padding(.vertical)
            
            Text(socialChat.content)
                .monospacedStyle(size: 16, weight: .regular)
                .multilineTextAlignment(.leading)
            Divider()
                .background(.mainApp)
            
            HStack(spacing:20){
                
                Group{
                    
                    //Like button
                    Button {
                        
                    } label: {
                        Image(systemName: "hand.thumbsup")
                        Text("\(socialChat.likes)")
                    }
                    
                    //Dislike button
                    Button{
                        
                    } label: {
                        Image(systemName: "hand.thumbsdown")
                        Text("\(socialChat.dislikes)")
                    }
                    
                    //Share button
                    Button{
                        
                    } label: {
                        Image (systemName: "arrowshape.turn.up.forward")
                    }
                }
                .tint(.mainApp)
                
                
            }
            
        }
        .padding()
        
    }
}

#Preview {
    SocialChatRow(socialChat: SocialChat(userId: "", publisherName: "Nick St", publisherProfileIcon: URL(string: "https://financialmodelingprep.com/image-stock/TSLA.png"), content: "Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin. The first two words themselves are a truncation of dolorem ipsum .", likes: 20, dislikes: 12))
}

