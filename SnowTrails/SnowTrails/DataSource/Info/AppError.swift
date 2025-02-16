//
//  LoginError.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

/// Representation of an app error
///
/// # Implementation
/// Use a custom init to create an instance from an (`Error`) or a (`RegexPattern`)
///
/// Usage:
///```swift
///let appError = AppError(from: error)
///
///let appError1 = AppError(from: .username)
///print(appError.errorDescription)
///```
///
///Output:
///```
///"Error: el nombre de usuario debe tener entre 8 y 24 carácteres"
///```
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
            self = .unknown // If the cast fails I set as default .unknown
            return
        }
        self = error
    }
    
    // This initializer was created to throw a custom error in the RegexLint
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
            return "Error: no se pudo iniciar la sesión, verifica tus datos"
        case .role:
            return "Error: no se pudo obtener el rol del usuario"
        case .username:
            return "Error: el nombre de usuario debe tener entre 8 y 24 carácteres"
        case .email:
            return "Error: el email deber tener la forma xxxxx@xxxxx.zz donde {xxx} puede ser cualquier carácter, mayúscula, minúscula o número y {zz} puede ser .es o .com"
        case .addUser:
            return "Error: no se pudo añadir al usuario"
        case .deleteUser:
            return "Error: el usuario que deseas eliminar no existe"
        case .logout:
            return "Error: no se pudo cerrar la sesión"
        case .unknown:
            return "Error: desconocido"
        }
    }
}
