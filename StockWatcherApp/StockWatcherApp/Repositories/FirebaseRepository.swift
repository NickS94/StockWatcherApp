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
    
    func createNewFirestoreUser(user:User) throws {
        let user = FirestoreUser(user: user)
        try firestoreInstance
            .collection("users")
            .document(user.id)
            .setData(from: user)
    }
    
    func getFirestoreUser() async throws -> FirestoreUser?{
        
        try await firestoreInstance
            .collection("users")
            .document(uid ?? "")
            .getDocument()
            .data(as: FirestoreUser.self)
    }
    
    func deleteUsersCollection(user:User)async throws{
        try await firestoreInstance
            .collection("users")
            .document(user.uid)
            .delete()
        
    }
    
    func createWatchlist(ticker:String)async throws{
        
    }
}
