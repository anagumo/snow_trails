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
    private var routesLoader: RoutesLoader
    private var routesService: RoutesService
    private var routesController: RoutesController
    private var menuController: MenuControllerImplementation
    
    init() {
        userDataLoader = UserDataLoader()
        loginService = LoginService(userDataLoader: userDataLoader)
        loginController = LoginController(loginService: loginService)
        userService = UserService(userDataLoader: userDataLoader)
        routesLoader = RoutesLoader()
        routesService = RoutesService(routesLoader: routesLoader)
        routesController = RoutesController(routesService: routesService)
        regularUserController = RegularUserController(userService: userService, routesController: routesController)
        menuController = MenuController(loginController: loginController, regularUserController: regularUserController)
    }
    
    func run() {
        menuController.open()
    }
}
