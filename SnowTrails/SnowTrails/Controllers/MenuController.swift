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
    private var menu: Menu?
    private var user: User?
    
    init(loginController: LoginControllerImplementation,
         regularUserController: UserControllerImplementation,
         adminController: UserControllerImplementation) {
        self.loginController = loginController
        self.regularUserController = regularUserController
        self.adminController = adminController
        menu = Menu(menuDelegate: self)
    }
    
    deinit {
        menu = nil
        user = nil
    }
    
    // MARK: Main
    func open() {
        // I set MenuController as delegate of these controllers to comunicate back when user closes it sesion
        loginController.loginControllerDelegate = self
        regularUserController.loginControllerDelegate = self
        adminController.loginControllerDelegate = self
        
        menu?.getMenu(.login) // The first menu by default is the Login, which is the beginning of the app.
    }
}

extension MenuController: MenuDelegate, LoginControllerDelegate {
    // MARK: Menu Delegate functions
    func displayLoginMenu(textMenu: String) {
        loginController.open(textMenu: textMenu)
    }
    
    func displayUserMenu(textMenu: String) {
        guard let user else {
            Logger.developerLog.error("Error: ocurrió un error al guardar el usuario")
            return
        }
        regularUserController.open(textMenu: textMenu, user: user)
    }
    
    func displayAdminMenu(textMenu: String) {
        guard let user else {
            Logger.developerLog.error("Error: ocurrió un error al guardar el usuario")
            return
        }
        adminController.open(textMenu: textMenu, user: user)
    }
    
    // MARK: Login Delegate functions
    func onLoginSuccess(user: User) {
        self.user = user // I need to set the user globally so it can be accessed in other controllers
        
        // Given the user's rol I trigger the rigth menu
        switch user.role {
        case .regular:
            menu?.getMenu(.regularUser)
        case .admin:
            menu?.getMenu(.admin)
        default:
            Logger.developerLog.error("Error: ocurrió un error al obtener el rol del usuario")
        }
    }
    
    // MARK: User Delegate functions
    func onLogoutSuccess() {
        user = nil
        loginController.quitLogin = false // Reset the data of LoginController to prevent the app from closing
        menu?.getMenu(.login)
    }
}
