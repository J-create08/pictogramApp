//
//  UserModel.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 4/4/21.
//

import Foundation

struct User: Encodable, Decodable {
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var searchName: [String]
    var bio: String
    
}
