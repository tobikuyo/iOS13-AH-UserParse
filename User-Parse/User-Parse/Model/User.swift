//
//  User.swift
//  User-Parse
//
//  Created by Tobi Kuyoro on 16/01/2020.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct UserResults: Decodable {
    let results: [User]
}

struct User: Decodable {
    var name: Name
    var email: String
    var phone: String
    var picture: Picture
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Picture: Decodable {
    var thumbnail: URL
    var large: URL
}
