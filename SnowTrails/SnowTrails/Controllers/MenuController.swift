//
//  MenuController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class MenuController: MenuDelegate {
    var menu: Menu?
    
    init() {
        menu = Menu(menuDelegate: self)
    }
    
    deinit {
        menu = nil
    }
    
    // MARK: Main Logic
    func displayMainMenu() {
        // TODO: Validate user session to display the correct menu
        menu?.getMenu(.Login)
    }
    
    // MARK: Delegate functions
    func displayLoginMenu(textMenu: String) {
        print(textMenu)
    }
    
    func displayUserMenu(textMenu: String) {
        print(textMenu)
    }
    
    func displayAdminMenu(textMenu: String) {
        print(textMenu)
    }
}
