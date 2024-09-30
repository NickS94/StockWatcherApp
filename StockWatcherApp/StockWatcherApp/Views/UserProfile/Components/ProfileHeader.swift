//
//  ProfileHeader.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 18.09.24.
//

import SwiftUI
import FirebaseAuth

struct ProfileHeader: View {
    @Binding var showUpdateProfileSheet:Bool
    let fireuser:FirestoreUser?
    
    var body: some View {
        VStack{
            
            AsyncImage(url:URL(string: fireuser?.userProfileIcon ?? "")){ image in
                image
                    .resizable()
                    .frame(width: 150,height: 150)
                    .clipShape(Circle())
                
            }placeholder: {
                Image(systemName: fireuser?.userProfileIcon ?? "")
                    .font(.system(size: 70))
                    .overlay {
                        Circle()
                            .frame(width: 150,height: 150)
                            .shadow(color: .mainApp, radius: 15)
                            .foregroundStyle(.mainApp.opacity(0.2))
                    }
                    .padding(.vertical,50)
            }
            HStack(alignment:.bottom){
                VStack (alignment:.leading){
                    Text(fireuser?.username ?? "")
                        .font(.title2)
                        .bold()
                        .italic()
                    Text(fireuser?.userEmail ?? "")
                }
                .padding(.horizontal)
                Button{
                    showUpdateProfileSheet = true
                }label: {
                    Image(systemName: "pencil")
                        .font(.title2.bold())
                        .foregroundStyle(.mainApp)
                }
                .frame(alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding()
    }
}

#Preview {
    ProfileHeader(showUpdateProfileSheet: .constant(false),fireuser: FirestoreUser(id: "something", username: "Nick", userEmail: "nick@gmail.com", userProfileIcon: "lizard.fill"))
}

