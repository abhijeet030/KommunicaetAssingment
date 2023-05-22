//
//  LoginView.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack {
                Image("LogoDark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 360, height: 240)

                
                VStack(spacing: 24){
                    FormField(text: $email, title: "Email Address", imageName: "mail")
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    FormField(text: $password, title: "Password", imageName: "key", isObsecured: true)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                Button{
                    Task{
                        try await viewModel.logIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack(spacing: 5){
                        Text("LOG IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color.accentColor)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 52)
                
                Spacer()
                
                NavigationLink{
                    SignupView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 2){
                        Text("Don't have an account?")
                        Text("SIGN UP")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProftocol {
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
