//
//  App.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class App {
    private var userDataLoader: UserDataLoader
    private var loginService: LoginServiceImplementation
    private var loginController: LoginControllerImplementation
    private var userService: UserService
    private var regularUserController: RegularUserControllerImplementation
    private var menuController: MenuControllerImplementation
    
    init() {
        userDataLoader = UserDataLoader()
        loginService = LoginService(userDataLoader: userDataLoader)
        loginController = LoginController(loginService: loginService)
        userService = UserService(userDataLoader: userDataLoader)
        regularUserController = RegularUserController(userService: userService)
        menuController = MenuController(loginController: loginController, regularUserController: regularUserController)
    }
    
    func run() {
        menuController.open()
    }
}
