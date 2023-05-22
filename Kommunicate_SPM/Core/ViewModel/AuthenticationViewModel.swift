//
//  AuthenticationViewModel.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Kommunicate

protocol AuthenticationFormProftocol {
    var formIsValid: Bool {get}
}


@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
        await registerKommunicateUser()
    }
    
    func signUp(fullname: String, withEmail email: String, phoneNumber: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let chatId = Kommunicate.randomId()
            let user = User(id: result.user.uid, fullname: fullname, email: email, phoneNumber: phoneNumber, kommunicateChatID: chatId)
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("Users").document(user.id).setData(encodeUser)
            await fetchUser()
            await registerKommunicateUser()
        } catch {
            print("Debug: Solve the error in SignUP \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("Users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func  signOut() {
        do{
            try Auth.auth().signOut() 
            logoutChat()
            self.userSession = nil
            self.currentUser = nil
        }catch{
            print("Debug: Sign Out error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async throws {
        do{
            guard let uid = Auth.auth().currentUser?.uid else {return}
            try await Firestore.firestore().collection("Users").document(uid).delete()
            try await Auth.auth().currentUser?.delete()
            self.userSession = nil
            self.currentUser = nil
        } catch{
            print("Debug: Solve the error in Delete Account \(error.localizedDescription)")
        }
    }
    
    // kommunicate integration
    
    func registerKommunicateUser() async {
        guard let chatId = currentUser?.kommunicateChatID else {return}
        guard let fullname = currentUser?.fullname else {return}
        guard let email = currentUser?.email else {return}
        guard let phoneNumber = currentUser?.phoneNumber else {return}
        
        let kmUser = KMUser()
        kmUser.userId = chatId
        kmUser.displayName = fullname
        kmUser.email = email
        kmUser.applicationId = Constants.AppId.appId
        kmUser.contactNumber = phoneNumber
        
        Kommunicate.registerUser(kmUser) { response, error in
            guard error == nil else {return}
            print("Successfully User is registered")
        }
    }
    
    func goToConversation() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        Kommunicate.showConversations(from: window?.rootViewController ?? UIViewController())
    }
    
    func logoutChat() {
        Kommunicate.logoutUser { (result) in
               switch result {
               case .success(_):
                   print("Logout success")
               case .failure( _):
                   print("Logout failure, now registering remote notifications(if not registered)")
                   if !UIApplication.shared.isRegisteredForRemoteNotifications {
                       UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                           if granted {
                               DispatchQueue.main.async {
                                   UIApplication.shared.registerForRemoteNotifications()
                               }
                           }
                       }
                   }
               }
           }
    }
}
