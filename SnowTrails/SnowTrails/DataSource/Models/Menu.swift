//
//  Menu.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

enum MenuType {
    case login
    case regularUser
    case admin
}

/// Representation of and option of Login
///
/// - Throws: AppError.menu if the input is invalid
///
/// # Implementation
/// Use a custom init to handle the user input, throw an error if the input is invalid.
///
/// Usage:
///```swift
///let loginOption = LoginOption("1")
///print(option)
///```
///
///Output:
///```
///Optional(SnowTrails.LoginOption.loginUser)
///```
enum LoginOption: String, CaseIterable {
    case loginUser = "Acceder como usuario"
    case loginAdmin = "Acceder como administrador"
    case quit = "Salir"
    
    init(from input: String) throws {
        switch input {
        case "1":
            self = .loginUser
        case "2":
            self = .loginAdmin
        case "3":
            self = .quit
        default:
            throw AppError.menu
        }
    }
}

/// Representation of and option of regular menu
///
/// - Throws: AppError.menu if the input is invalid
///
/// # Implementation
/// Use a custom init to handle the user input, throw an error if the input is invalid.
///
/// Usage:
///```swift
///let regularUserOption = RegularUserOption("3")
///print(option)
///```
///
///Output:
///```
///Optional(SnowTrails.RegularUserOption.logout)
///```
enum RegularUserOption: String, CaseIterable {
    case routes = "Ver todas las rutas"
    case shortRoute = "Obtener la ruta más corta entre dos puntos"
    case logout = "Cerrar sesión"
    
    init(from input: String) throws {
        switch input {
        case "1":
            self = .routes
        case "2":
            self = .shortRoute
        case "3":
            self = .logout
        default:
            throw AppError.menu
        }
    }
}

/// Representation of and option of admin menu
///
/// - Throws: AppError.menu if the input is invalid
///
/// # Implementation
/// Use a custom init to handle the user input, throw an error if the input is invalid.
///
/// Usage:
///```adminOption("3")
///print(option)
///```
///
///Output:
///```
///Optional(SnowTrails.AdminOption.deleteUser)
///```
enum AdminOption: String, CaseIterable {
    case users = "Ver todos los usuarios"
    case addUser = "Añadir usuario"
    case deleteUser = "Eliminar usuario"
    case addPointToRoute = "Añadir punto a ruta"
    case logout = "Cerrar sesión"
    
    init(from input: String) throws {
        switch input {
        case "1":
            self = .users
        case "2":
            self = .addUser
        case "3":
            self = .deleteUser
        case "4":
            self = .addPointToRoute
        case "5":
            self = .logout
        default:
            throw AppError.menu
        }
    }
}
