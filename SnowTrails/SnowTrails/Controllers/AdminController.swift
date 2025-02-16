//
//  AdminController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation
import OSLog

class AdminController: UserControllerImplementation {
    private let userService: UserService
    weak var loginControllerDelegate: LoginControllerDelegate?
    private var isLoggedIn: Bool
    
    init(userService: UserService) {
        self.userService = userService
        isLoggedIn = false
    }
    
    deinit {
        loginControllerDelegate = nil
    }
    
    func open(textMenu: String, user: User) {
        isLoggedIn = user.isLoggedIn
        
        while isLoggedIn {
            Logger.userLog.log("\(textMenu)")
            
            do {
                let adminOption = try AdminOption(from: readLine() ?? "")
                switch adminOption {
                case .users:
                    getUsers()
                case .addUser:
                    addUser()
                case .deleteUser:
                    deleteUser()
                case .addPointToRoute:
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
    
    private func getUsers() {
        userService.getAll { users in
            do {
                let usersText = try users.reduce("") {
                    return $0 + (try $1.getDescription()) + "\n"
                }
                Logger.userLog.log("\(usersText)")
            } catch {
                Logger.userLog.error("\(AppError(from: error).errorDescription)")
            }
        } onError: { appError in
            Logger.userLog.error("\(appError.errorDescription)")
        }
    }
    
    private func addUser() {
        var usernameInput = ""
        var emailInput = ""
        
        while usernameInput.isEmpty {
            Logger.userLog.log("Introduce el nombre del usuario que quieres añadir")
            usernameInput = readLine() ?? ""
            
            userService.validate(text: usernameInput, regexPattern: .username) {
                usernameInput = $0
            } onError: { appError in
                usernameInput.removeAll()
                Logger.userLog.error("\(appError.errorDescription)")
            }
        }
        
        while emailInput.isEmpty {
            Logger.userLog.log("Introduce el email del usuario que quieres añadir")
            emailInput = readLine() ?? ""
            
            userService.validate(text: emailInput, regexPattern: .email) {
                emailInput = $0
            } onError: { appError in
                emailInput.removeAll()
                Logger.userLog.error("\(appError.errorDescription)")
            }
        }
        
        Logger.userLog.log("Introduce la contraseña del usuario que quieres añadir")
        let passwordInput = readLine() ?? ""
        
        userService.addUser(username: usernameInput, email: emailInput, password: passwordInput) { successMessage, user in
            Logger.userLog.info("\(successMessage)")
        } onError: { appError in
            Logger.userLog.error("\(appError.errorDescription)")
        }
    }
    
    private func deleteUser() {
        Logger.userLog.log("Introduce el nombre del usuario que quieras eliminar")
        let username = readLine() ?? ""
        
        userService.deleteUser(username: username) { succesMessage in
            Logger.userLog.info("\(succesMessage)")
        } onError: { appError in
            Logger.userLog.error("\(appError.errorDescription)")
        }
    }
    
    func logout(userId: String) {
        userService.logout(userId: userId) { successMessage in
            isLoggedIn = false
            Logger.userLog.info("\(successMessage)")
            loginControllerDelegate?.onLogoutSuccess()
        } onError: { appError in
            Logger.userLog.error("\(appError.errorDescription)")
        }
    }
}
