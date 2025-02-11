//
//  App.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class App {
    private var menuController: MenuControllerImplementation
    
    init() {
        let userDataLoader = UserDataLoader()
        let loginService = LoginService(userDataLoader: userDataLoader)
        let loginController = LoginController(loginService: loginService)
        let userService = UserService(userDataLoader: userDataLoader)
        let adminController = AdminController()
        let routesLoader = RoutesLoader()
        let routesService = RoutesService(routesLoader: routesLoader)
        let routesController = RoutesController(routesService: routesService)
        let regularUserController = RegularUserController(userService: userService, routesController: routesController)
        menuController = MenuController(loginController: loginController,
                                        regularUserController: regularUserController,
                                        adminController: adminController)
    }
    
    func run() {
        menuController.open()
    }
}
