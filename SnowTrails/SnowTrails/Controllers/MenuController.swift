//
//  MenuController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation
import OSLog

protocol MenuControllerImplementation {
    func open()
}

class MenuController: MenuControllerImplementation {
    private var loginController: LoginControllerImplementation
    private var regularUserController: UserControllerImplementation
    private var adminController: UserControllerImplementation
    private var user: User?
    
    init(loginController: LoginControllerImplementation,
         regularUserController: UserControllerImplementation,
         adminController: UserControllerImplementation) {
        self.loginController = loginController
        self.regularUserController = regularUserController
        self.adminController = adminController
    }
    
    deinit {
        user = nil
    }
    
    // MARK: Main
    /// Implementation of the SnowTrails where the user can see  routes easy and fast.
    func open() {
        // I set MenuController as delegate of these controllers to comunicate back when user closes it sesion
        loginController.loginControllerDelegate = self
        regularUserController.loginControllerDelegate = self
        adminController.loginControllerDelegate = self
        
        buildMenu() // The first menu by default is the Login, which is the beginning of the app.
    }
    
    // MARK: Menu functions
    /// Builds a menu
    /// - Parameter type: an enum case of type (`MenuType`),
    private func buildMenu(_ type: MenuType = .login) {
        switch type {
        case .login:
            displayLoginMenu()
        case .regularUser:
            displayRegularUserMenu()
        case .admin:
            displayAdminMenu()
        }
    }
    
    private func displayLoginMenu() {
        let textMenu = LoginOption.allCases
            .enumerated()
            .reduce("🏔️ Bienvenido a SnowTrails\n") {
                let (index, option) = $1
                return $0 + "\(index + 1). \(option.rawValue)\n"
            }
        
        loginController.open(textMenu: textMenu)
    }
    
    private func displayRegularUserMenu() {
        let textMenu = RegularUserOption.allCases
            .enumerated()
            .reduce("👩🏻‍💻 Menú usuario - Selecciona una opción:\n") {
                let (index, option) = $1
                return $0 + "\(index + 1). \(option.rawValue)\n"
            }
        
        guard let user else {
            Logger.developerLog.error("Error: ocurrió un error al guardar el usuario")
            return
        }
        regularUserController.open(textMenu: textMenu, user: user)
    }
    
    private func displayAdminMenu() {
        let textMenu = AdminOption.allCases
            .enumerated()
            .reduce("👩🏻‍💼 Menú admin - Selecciona una opción:\n") {
                let (index, option) = $1
                return $0 + "\(index + 1). \(option.rawValue)\n"
            }
        
        guard let user else {
            Logger.developerLog.error("Error: ocurrió un error al guardar el usuario")
            return
        }
        adminController.open(textMenu: textMenu, user: user)
    }
}

extension MenuController: LoginControllerDelegate {
    // MARK: Login Delegate functions
    func onLoginSuccess(user: User) {
        self.user = user // I need to set the user globally so it can be accessed in other controllers
        
        // Given the user's rol, I trigger the rigth menu
        switch user.role {
        case .regular:
            buildMenu(.regularUser)
        case .admin:
            buildMenu(.admin)
        default:
            Logger.developerLog.error("Error: ocurrió un error al obtener el rol del usuario")
        }
    }
    
    // MARK: User Delegate functions
    func onLogoutSuccess() {
        user = nil
        loginController.quitLogin = false // Reset the data of LoginController to prevent the app from closing
        buildMenu(.login)
    }
}
