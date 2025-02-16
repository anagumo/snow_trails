//
//  Menu.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

protocol MenuImplementation {
    func getMenu(_ menuType: MenuType)
}

protocol MenuDelegate {
    func displayLoginMenu(textMenu: String)
    func displayUserMenu(textMenu: String)
    func displayAdminMenu(textMenu: String)
}

struct Menu: MenuImplementation {
    var menuDelegate: MenuDelegate?
    
    func getMenu(_ menuType: MenuType) {
        switch menuType {
        case .login:
            displayLoginMenu()
        case .regularUser:
            displayRegularUserMenu()
        case .admin:
            displayAdminMenu()
        }
    }
    
    func displayLoginMenu() {
        let textMenu = LoginOption.allCases
            .enumerated()
            .reduce("🏔️ Bienvenido a SnowTrails\n") {
                let (index, option) = $1
                return $0 + "\(index + 1). \(option.rawValue)\n"
            }
        
        menuDelegate?.displayLoginMenu(textMenu: textMenu)
    }
    
    func displayRegularUserMenu() {
        let textMenu = RegularUserOption.allCases
            .enumerated()
            .reduce("👩🏻‍💻 Menú usuario - Selecciona una opción:\n") {
                let (index, option) = $1
                return $0 + "\(index + 1). \(option.rawValue)\n"
            }
        
        menuDelegate?.displayUserMenu(textMenu: textMenu)
    }
    
    func displayAdminMenu() {
        let textMenu = AdminOption.allCases
            .enumerated()
            .reduce("👩🏻‍💼 Menú admin - Selecciona una opción:\n") {
                let (index, option) = $1
                return $0 + "\(index + 1). \(option.rawValue)\n"
            }
        
        menuDelegate?.displayAdminMenu(textMenu: textMenu)
    }
}

enum MenuType {
    case login
    case regularUser
    case admin
}

/// Representation of and option of Login
///
/// - throws: AppError.menu if the input is invalid
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
/// - throws: AppError.menu if the input is invalid
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
/// - throws: AppError.menu if the input is invalid
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
