//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol UserControllerImplementation {
    func open(textMenu: String, user: User)
    var loginControllerDelegate: LoginControllerDelegate? { get set }
}

class RegularUserController: UserControllerImplementation {
    private var userService: UserService
    private var routesController: RoutesControllerImplementation
    weak var loginControllerDelegate: LoginControllerDelegate?
    private var isLoggedIn: Bool = true
    
    init(userService: UserService, routesController: RoutesControllerImplementation) {
        self.userService = userService
        self.routesController = routesController
    }
    
    deinit {
        loginControllerDelegate = nil
    }
    
    func open(textMenu: String, user: User) {
        isLoggedIn = user.isLoggedIn
        
        while isLoggedIn {
            print(textMenu)
            
            if let regularUserOption = RegularUserOption(from: readLine() ?? nil) {
                switch regularUserOption {
                case .Routes:
                    routesController.getRoutes()
                case .ShortRoute:
                    print("Esta funcionalidad no está implementada")
                case .Logout:
                    logout(userId: user.id)
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
    
    private func logout(userId: String) {
        userService.logout(userId: userId) { onSuccessMessage in
            isLoggedIn = false
            print(onSuccessMessage)
            loginControllerDelegate?.onLogoutSuccess()
        } onError: { errorMessage in
            print(errorMessage)
        }
    }
}
