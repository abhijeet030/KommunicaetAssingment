//
//  SignupView.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var verifyPassword = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("LogoDark")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.accentColor)
                .frame(width: 360)
                .padding(.top, 35)
            
            
            VStack(spacing: 24){
                FormField(text: $name, title: "Name", imageName: "person")
                    .autocorrectionDisabled()
                FormField(text: $email, title: "Email Address", imageName: "mail")
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                FormField(text: $phoneNumber, title: "Phone Number", imageName: "phone")
                FormField(text: $password, title: "Password", imageName: "key", isObsecured: true)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                ZStack(alignment: .trailing){
                    FormField(text: $verifyPassword, title: "Password Verify", imageName: "key", isObsecured: true)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    if !password.isEmpty && !verifyPassword.isEmpty{
                        if( password == verifyPassword){
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            Button{
                Task{
                    try await viewModel.signUp(fullname: name, withEmail: email, phoneNumber: phoneNumber, password: password)
                }
            } label: {
                HStack(spacing: 5){
                    Text("SIGN UP")
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
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 2){
                    Text("Do have an account?")
                    Text("LOG IN")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

extension SignupView: AuthenticationFormProftocol {
    var formIsValid: Bool{
        return !name.isEmpty
        && !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && verifyPassword == password
        && password.count > 5
        && phoneNumber.count == 10
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
