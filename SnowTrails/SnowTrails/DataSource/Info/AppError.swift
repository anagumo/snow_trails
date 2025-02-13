//
//  LoginError.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case menu
    case login
    case role
    case username
    case email
    case unknown
    
    init(from error: Error) {
        guard let error = error as? AppError else {
            self = .unknown
            return
        }
        self = error
    }
    
    init(from regex: RegexPattern) {
        switch regex {
        case .email:
            self = .email
        case .username:
            self = .username
        }
    }
    
    var errorDescription: String {
        switch self {
        case .menu:
            return "Opción inválida"
        case .login:
            return "Ocurrió un error al iniciar sesión"
        case .role:
            return "Error: No se pudo obtener el rol del usuario"
        case .unknown:
            return "Error: Ocurrió un error desconocido"
        case .username:
            return "Error: El nombre de usuario debe tener entre 8 y 24 carácteres"
        case .email:
            return "Error: El email deber tener la forma xxxxx@xxxxx.zz donde {xxx} puede ser cualquier carácter, mayúscula, minúscula o número y {zz} puede ser .es o .com"
        }
    }
}
