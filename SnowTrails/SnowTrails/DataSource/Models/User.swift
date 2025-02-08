//
//  User.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

enum UserType {
    case regular
    case admin
}

struct User {
    let id: String
    let username: String
    let email: String
    let password: String
    let role: UserType
    let isLogged: Bool
}
