//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation
import OSLog

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
            Logger.userLog.log("\(textMenu)")
            
            if let regularUserOption = RegularUserOption(from: readLine() ?? nil) {
                switch regularUserOption {
                case .Routes:
                    routesController.getRoutes()
                case .ShortRoute:
                    Logger.userLog.warning("Esta funcionalidad no está implementada")
                case .Logout:
                    logout(userId: user.id)
                }
            } else {
                //TODO: Complementary - Handle Menu error
                Logger.userLog.error("Opción inválida")
            }
        }
    }
    
    private func logout(userId: String) {
        userService.logout(userId: userId) { successMessage in
            isLoggedIn = false
            Logger.userLog.info("\(successMessage)")
            loginControllerDelegate?.onLogoutSuccess()
        } onError: { errorMessage in
            Logger.userLog.error("\(errorMessage)")
        }
    }
}
