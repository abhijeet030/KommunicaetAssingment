//
//  UserModel.swift
//  Kommunicate_SPM
//
//  Created by Abhijeet Ranjan  on 22/05/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let phoneNumber: String
    let kommunicateChatID: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
             formatter.style = .abbreviated
             return formatter.string(from: components)
        }
        return ""
    }
}
