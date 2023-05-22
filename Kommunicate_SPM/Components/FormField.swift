//
//  FormField.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import SwiftUI

struct FormField: View {
        @Binding var text:  String
        let title: String
        let imageName: String
        var isObsecured = false
        
        var body: some View {
            HStack(spacing: 20){
                Image(systemName: imageName)
                    .foregroundColor(Color.accentColor)
                    .font(.body)
                    if isObsecured {
                        SecureField(title, text: $text)
                            .font(.system(size: 14))
                    } else {
                        TextField(title, text: $text)
                            .font(.system(size: 14))
                    }
            }
            .padding()
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
            )
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField(text: .constant(""), title: "Email Address", imageName: "mail")
    }
}
