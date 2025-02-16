//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation
import OSLog

// User controllers shares this protocol
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
            
            // Creates the RegularUserOption and handles the error
            do {
                let regularUserOption = try RegularUserOption(from: readLine() ?? "")
                switch regularUserOption {
                case .routes:
                    routesController.getRoutes()
                case .shortRoute:
                    Logger.userLog.warning("Esta funcionalidad no está implementada")
                case .logout:
                    logout(userId: user.id)
                }
            } catch let error as AppError {
                Logger.userLog.error("\(error.errorDescription)")
            } catch {
                Logger.userLog.error("\(AppError.unknown.errorDescription)")
            }
        }
    }
    
    private func logout(userId: String) {
        userService.logout(userId: userId) { successMessage in
            isLoggedIn = false
            Logger.userLog.info("\(successMessage)")
            loginControllerDelegate?.onLogoutSuccess()
        } onError: { appError in
            Logger.userLog.error("\(appError.errorDescription)")
        }
    }
}
