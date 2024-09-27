//
//  ProfileHeader.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 18.09.24.
//

import SwiftUI
import FirebaseAuth

struct ProfileHeader: View {
    let userProfile :User?
    let fireuser:FirestoreUser?
    
    var body: some View {
        VStack{
            AsyncImage(url: userProfile?.photoURL){ image in
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
            Text(fireuser?.username ?? "")
                .font(.title2)
                .bold()
                .italic()
            Text(fireuser?.userEmail ?? "")
        }
        .padding()
    }
}


