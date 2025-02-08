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

class MenuController: MenuControllerImplementation, MenuDelegate {
    private var menu: Menu?
    private var loginController: LoginControllerImplementation
    
    init(loginController: LoginControllerImplementation) {
        self.loginController = loginController
        menu = Menu(type: .Login, menuDelegate: self)
    }
    
    deinit {
        menu = nil
    }
    
    // MARK: Main
    func build() {
        // TODO: Validate user session to display the correct menu
        menu?.getMenu(.Login)
    }
    
    // MARK: Delegate functions
    func displayLoginMenu(textMenu: String) {
        loginController.displayMenu(textMenu: textMenu)
    }
    
    func displayUserMenu(textMenu: String) {
        print(textMenu)
    }
    
    func displayAdminMenu(textMenu: String) {
        print(textMenu)
    }
}
