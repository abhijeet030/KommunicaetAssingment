//
//  ProfileRowItem.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import SwiftUI

struct ProfileRowItem: View {
    let imageName: String
    let title: String
    let tintColor: Color
    var showTrailingText = false
    var trailingText = "1.0.0"
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
            if showTrailingText {
                Text(trailingText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ProfileRowItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRowItem(imageName: "gear", title: "Version", tintColor: Color(.systemGray), showTrailingText: true)
    }
}
