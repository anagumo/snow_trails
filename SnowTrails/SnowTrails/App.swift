//
//  App.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class App {
    var menuController: MenuController
    var loginController: LoginController
    
    init() {
        loginController = LoginController()
        menuController = MenuController(loginController: loginController)
    }
    
    func run() {
        menuController.build()
    }
}
