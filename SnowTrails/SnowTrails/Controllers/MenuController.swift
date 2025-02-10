//
//  MenuController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

protocol MenuControllerImplementation {
    func open()
}

class MenuController: MenuControllerImplementation {
    private var loginController: LoginControllerImplementation
    private var regularUserController: RegularUserControllerImplementation
    private var menu: Menu?
    private var user: User?
    
    init(loginController: LoginControllerImplementation, regularUserController: RegularUserControllerImplementation) {
        self.loginController = loginController
        self.regularUserController = regularUserController
        menu = Menu(menuDelegate: self)
    }
    
    deinit {
        menu = nil
        user = nil
    }
    
    // MARK: Main
    func open() {
        loginController.loginControllerDelegate = self
        regularUserController.regularUserControllerDelegate = self
        menu?.getMenu(.Login)
    }
}

extension MenuController: MenuDelegate, LoginControllerDelegate, RegularUserControllerDelegate {
    // MARK: Menu Delegate functions
    func displayLoginMenu(textMenu: String) {
        loginController.open(textMenu: textMenu)
    }
    
    func displayUserMenu(textMenu: String) {
        guard let user else {
            print("No se encontró el usuario")
            return
        }
        regularUserController.open(texMenu: textMenu, user: user)
    }
    
    func displayAdminMenu(textMenu: String) {
        print(textMenu)
    }
    
    // MARK: Login Delegate functions
    func onLoginSuccess(user: User) {
        self.user = user
        
        switch user.role {
        case .regular:
            menu?.getMenu(.RegularUser)
        case .admin:
            print("Display admin user menu")
        default:
            // TODO: Complementary - Handle error
            print("Tipo de usuario no identificado")
        }
    }
    
    // MARK: User Delegate functions
    func onLogoutSuccess() {
        user = nil
        loginController.quitLogin = false
        menu?.getMenu(.Login)
    }
}
