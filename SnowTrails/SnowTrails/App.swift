//
//  App.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class App {
    private var menuController: MenuControllerImplementation
    private var loginController: LoginControllerImplementation
    private var loginService: LoginServiceImplementation
    
    init() {
        loginService = LoginService()
        loginController = LoginController(loginService: loginService)
        menuController = MenuController(loginController: loginController)
    }
    
    func run() {
        menuController.build()
    }
}
