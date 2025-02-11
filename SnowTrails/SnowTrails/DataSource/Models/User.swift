//
//  User.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

enum UserType: String, Codable {
    case regular
    case admin
    
    // It was great create an enum from a JSON response :P
    init?(from decoder: Decoder?) throws {
        let container = try decoder?.singleValueContainer()
        let userRole = try container?.decode(String.self)
        
        switch userRole {
        case UserType.regular.rawValue:
            self = .regular
        case UserType.admin.rawValue:
            self = .admin
        default:
            return nil
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .regular:
            return "Regular user"
        case .admin:
            return "Admin"
        }
    }
}

struct UserResponse: Codable {
    let users: [User]
}

struct User: Codable, Hashable {
    let id: String
    let username: String
    let email: String
    let password: String
    let role: UserType?
    var isLoggedIn: Bool
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func getDescription() throws -> String {
        let role = try getRole()
        return "\(role.getDescription()): \(username) --- Email: \(email)"
    }
    
    func getRole() throws -> UserType {
        guard let role else {
            throw UserError.role
        }
        
        return role
    }
    
    // MARK: Success messages
    func getLoginMessage() -> String {
        guard let role else {
            return "Has iniciado sesión correctamente\n"
        }
        
        return "Has iniciado sesión correctamente como usuario \(role)\n"
    }
    
    func getAddUserMessage() -> String {
        "Usuario \(username) con email \(email) añadido satisfactoriamente\n"
    }
}
