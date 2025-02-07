//
//  Menu.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

enum LoginMenu {
    case LoginUser
    case LoginAdmin
    case Quit
}

enum UserMenu {
    case Routes
    case ShortRoute
    case Logout
}

enum AdminMenu {
    case Users
    case AddUser
    case DeleteUser
    case AddPointToRoute
    case Logout
}
