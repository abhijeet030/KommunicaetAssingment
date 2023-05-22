//
//  Kommunicate_SPMApp.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import SwiftUI
import Firebase
import Kommunicate

@main
struct Kommunicate_SPMApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
        Kommunicate.setup(applicationId: Constants.AppId.appId)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
