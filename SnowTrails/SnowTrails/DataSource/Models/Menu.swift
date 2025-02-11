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
        case .Login:
            displayLoginMenu()
        case .RegularUser:
            displayRegularUserMenu()
        case .Admin:
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
    case Login
    case RegularUser
    case Admin
}

enum LoginOption: String, CaseIterable {
    case LoginUser = "Acceder como usuario"
    case LoginAdmin = "Acceder como administrador"
    case Quit = "Salir"
    
    init?(from input: String?) {
        switch input {
        case "1":
            self = .LoginUser
        case "2":
            self = .LoginAdmin
        case "3":
            self = .Quit
        default:
            return nil
        }
    }
}

enum RegularUserOption: String, CaseIterable {
    case Routes = "Ver todas las rutas"
    case ShortRoute = "Obtener la ruta más corta entre dos puntos"
    case Logout = "Cerrar sesión"
    
    init?(from input: String?) {
        switch input {
        case "1":
            self = .Routes
        case "2":
            self = .ShortRoute
        case "3":
            self = .Logout
        default:
            return nil
        }
    }
}

enum AdminOption: String, CaseIterable {
    case Users = "Ver todos los usuarios"
    case AddUser = "Añadir usuario"
    case DeleteUser = "Eliminar usuario"
    case AddPointToRoute = "Añadir punto a ruta"
    case Logout = "Cerrar sesión"
    
    init?(from input: String?) {
        switch input {
        case "1":
            self = .Users
        case "2":
            self = .AddUser
        case "3":
            self = .DeleteUser
        case "4":
            self = .AddPointToRoute
        case "5":
            self = .Logout
        default:
            return nil
        }
    }
}
