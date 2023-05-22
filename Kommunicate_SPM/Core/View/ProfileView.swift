//
//  ProfileView.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel:  AuthViewModel
    @State var convId: String?
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section{
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72,height: 72)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.leading, 2)
                        }
                    }
                }
                Section("Genral"){
                    ProfileRowItem(imageName: "gear", title: "Version", tintColor: Color(.systemGray),showTrailingText: true)
                }
                Section("Help"){
                    Button{
                        viewModel.goToConversation()
                    } label: {
                        ProfileRowItem(imageName: "message.and.waveform.fill", title: "Kommunicate", tintColor: Color.accentColor)
                    }
                }
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    } label: {
                        ProfileRowItem(imageName: "arrowshape.turn.up.backward.circle.fill", title: "Log out", tintColor: Color(.systemRed))
                    }
                    Button{
                        Task{
                        try await viewModel.deleteAccount()
                        }
                    } label: {
                        ProfileRowItem(imageName: "trash.circle.fill", title: "Delete Account", tintColor: Color(.systemRed))
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
