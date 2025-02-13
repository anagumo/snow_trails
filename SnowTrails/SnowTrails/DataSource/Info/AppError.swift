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
    case addUser
    case deleteUser
    case logout
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
            return "Error: opción inválida, elige una opción del menú"
        case .login:
            return "Error: no se pudo iniciar la sesión"
        case .role:
            return "Error: no se pudo obtener el rol del usuario"
        case .username:
            return "Error: el nombre de usuario debe tener entre 8 y 24 carácteres"
        case .email:
            return "Error: el email deber tener la forma xxxxx@xxxxx.zz donde {xxx} puede ser cualquier carácter, mayúscula, minúscula o número y {zz} puede ser .es o .com"
        case .addUser:
            return "Error: no se pudo añadir al usuario"
        case .deleteUser:
            return "Error: el usuario que deseas eliminar no existe\n"
        case .logout:
            return "Error: no se pudo cerrar la sesión"
        case .unknown:
            return "Error: desconocido"
        }
    }
}
