//
//  FirebaseRepository.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 16.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class FirebaseRepository{
    
    static let shared = FirebaseRepository()
    
    private let authInstance = Auth.auth()
    private let firestoreInstance = Firestore.firestore()
    
    var uid:String?{
        authInstance.currentUser?.uid
    }
    
    func checkAuth() -> User? {
        return authInstance.currentUser
    }
    
    func newUserRegister(_ email:String,_ password:String,_ username:String) async throws -> User {
        let results = try await authInstance.createUser(withEmail: email, password: password)
        results.user.setValue(username, forKey: "displayName")
        return  results.user
    }
    
    func userSignIn(_ email:String,_ password:String) async throws -> User {
        let results = try await authInstance.signIn(withEmail: email, password: password)
        return results.user
    }
    
    func logout() throws {
        try authInstance.signOut()
    }
    
    func deleteUser() async throws {
        if let user = authInstance.currentUser {
            try await user.delete()
        }
    }
    
    @MainActor
    func signInWithGoogle() async -> User?{
        
        guard let clientID = FirebaseApp.app()?.options.clientID else{
            print("Client ID not exicted")
            return nil
        }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene =  UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window =  windowScene.windows.first,
              let rootViewController =  window.rootViewController else{
            print("There is no root view controller")
            return nil
        }
        do{
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else{
                return nil
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            return result.user
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    func createNewFirestoreUser(user:User,userProfileIcon:String) throws {
        let user = FirestoreUser(user: user, userProfileIcon: userProfileIcon)
        try firestoreInstance
            .collection("Users")
            .document(user.id)
            .setData(from: user.self)
    }
    
    func getFirestoreUser() async throws -> FirestoreUser?{
        try await firestoreInstance
            .collection("Users")
            .document(uid ?? "")
            .getDocument()
            .data(as: FirestoreUser.self)
    }
    
    func fetchFirestoreUsers() async throws -> [FirestoreUser]{
        
        try await firestoreInstance
            .collection("Users")
            .getDocuments()
            .documents
            .map{try $0.data(as: FirestoreUser.self)}
        
    }
    
    func deleteUsersCollection(user:User)async throws{
        try await firestoreInstance
            .collection("users")
            .document(user.uid)
            .delete()
    }
    
    func createAndUpdateWatchlist(ticker:String) throws {
        let newTicker = WatchlistTicker(id: ticker, tickerSymbol: ticker)
        try firestoreInstance
            .collection("Users")
            .document(uid ?? "")
            .collection("Watchlist")
            .document(ticker)
            .setData(from: newTicker)
    }
    
    func deleteFromWatchlist(ticker:String)async throws{
        try await firestoreInstance
            .collection("Users")
            .document(uid ?? "")
            .collection("Watchlist")
            .document(ticker)
            .delete()
    }
    
    func fetchUserWatchlist() async throws -> [String]{
        var stringTickers:[String] = []
        let firebaseWatchlistTickers = try await firestoreInstance
            .collection("Users")
            .document(uid ?? "")
            .collection("Watchlist")
            .getDocuments()
            .documents
            .map{try $0.data(as: WatchlistTicker.self)}
        
        for ticker in firebaseWatchlistTickers{
            stringTickers.append(ticker.tickerSymbol)
        }
        return stringTickers
    }
    
    func createSocialChat(fireuser:FirestoreUser,user:User,title:String,content:String) throws{
        
        let chat = SocialChat(
            userId:user.uid,
            publisherName: user.displayName ?? fireuser.username,
            publisherProfileIcon: user.photoURL,
            title: title,
            content: content,
            likes: 0,
            dislikes: 0)
        
        try firestoreInstance
            .collection("SocialChats")
            .document(chat.id)
            .setData(from: chat)
    }
    
    func fetchSocialChats()async throws->[SocialChat]{
        return try await firestoreInstance
            .collection("SocialChats")
            .getDocuments()
            .documents
            .map{try $0.data(as: SocialChat.self)}
    }
    
    func createAndUpdateChatComment(user:User,chat:SocialChat,content:String,likes:Int,dislikes:Int) throws {
        let chatComment = ChatComment(
            chatId: chat.id ,
            userId:user.uid,
            publisherName: user.displayName ?? "",
            publisherProfileIcon: user.photoURL,
            content: content,
            likes: likes,
            dislikes: dislikes)
        
        try firestoreInstance
            .collection("ChatComments")
            .document(chatComment.id ?? "")
            .setData(from: chatComment,merge: true)
    }
    
    func fetchChatComments(with chatId:String) async throws -> [ChatComment] {
        return try await firestoreInstance
            .collection("ChatComments")
            .whereField("chatId", isEqualTo: chatId)
            .getDocuments()
            .documents
            .map{try $0.data(as: ChatComment.self)}
    }
    
    func likeOrDislikeAPost(user:User,chatId:String,isLiked:Bool,isDisliked:Bool) throws{
        let interactionId = UUID().uuidString
        let interaction = LikedOrDislikedPost( id: interactionId,chatId:chatId, userId:user.uid,isLiked: isLiked, isDisliked: isDisliked)
        
        try firestoreInstance
            .collection("PostInteractions")
            .document(interactionId)
            .setData(from: interaction)
    }
    
    func deletePostInteraction( with interactionId:String) async throws{
        try await firestoreInstance
            .collection("PostInteractions")
            .document(interactionId)
            .delete()
    }
    
    func fetchPostInteractions() async throws -> [LikedOrDislikedPost]{
        
        return try await firestoreInstance
            .collection("PostInteractions")
            .getDocuments()
            .documents
            .map{try $0.data(as: LikedOrDislikedPost.self)}
    }
    
    func fetchInteraction(from userId:String)async throws -> [LikedOrDislikedPost]{
        return try await firestoreInstance
            .collection("PostInteractions")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
            .documents
            .map{try $0.data(as: LikedOrDislikedPost.self)}
    }
    
    
    func updatePostLikes(postId:String,likeCount:Int)async throws{
        
        let updatePost:[String:Any] = [
            "likes" : likeCount
        ]
        
        try await firestoreInstance
            .collection("SocialChats")
            .document(postId)
            .updateData(updatePost)
    }
    
    func updatePostDislikes(postId:String,dislikeCount:Int)async throws{
        let updatePost:[String:Any] = [
            "dislikes" : dislikeCount
        ]
        
        try await firestoreInstance
            .collection("SocialChats")
            .document(postId)
            .updateData(updatePost)
    }
}
