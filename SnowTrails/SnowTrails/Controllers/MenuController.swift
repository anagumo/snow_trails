//
//  MenuController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

protocol MenuControllerImplementation {
    func build()
}

class MenuController: MenuControllerImplementation {
    private var menu: Menu?
    private var loginController: LoginControllerImplementation
    private var regularUserController: RegularUserControllerImplementation
    
    init(loginController: LoginControllerImplementation, regularUserController: RegularUserControllerImplementation) {
        self.loginController = loginController
        self.regularUserController = regularUserController
        menu = Menu(menuDelegate: self)
    }
    
    deinit {
        menu = nil
    }
    
    // MARK: Main
    func build() {
        loginController.loginControllerDelegate = self
        menu?.getMenu(.Login)
    }
}

extension MenuController: MenuDelegate, LoginControllerDelegate {
    // MARK: Menu Delegate functions
    func displayLoginMenu(textMenu: String) {
        loginController.displayMenu(textMenu: textMenu)
    }
    
    func displayUserMenu(textMenu: String) {
        regularUserController.displayMenu(texMenu: textMenu)
    }
    
    func displayAdminMenu(textMenu: String) {
        print(textMenu)
    }
    
    // MARK: Login Delegate functions
    func onLoginSuccess(user: User) {
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
}
