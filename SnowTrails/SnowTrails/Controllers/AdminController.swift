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
                case .Users:
                    getUsers()
                case .AddUser:
                    addUser()
                case .DeleteUser:
                    deleteUser()
                case .AddPointToRoute:
                    Logger.userLog.warning("Esta funcionalidad no está implementada")
                case .Logout:
                    logout(userId: user.id)
                }
            } catch {
                guard let appError = error as? AppError else {
                    return Logger.userLog.error("\(AppError.unknown.errorDescription)")
                }
                Logger.userLog.error("\(appError.errorDescription)")
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
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            Logger.userLog.error("\(errorMessage)")
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
        
        userService.addUser(username: usernameInput, email: emailInput, password: passwordInput) { user in
            Logger.userLog.info("\(user.getAddUserMessage())")
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            Logger.userLog.error("\(errorMessage)")
        }
    }
    
    private func deleteUser() {
        Logger.userLog.log("Introduce el nombre del usuario que quieras eliminar")
        let username = readLine() ?? ""
        
        userService.deleteUser(username: username) {
            Logger.userLog.info("Usuario eliminado satisfactoriamente")
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            Logger.userLog.error("\(errorMessage)")
        }
    }
    
    func logout(userId: String) {
        userService.logout(userId: userId) { successMessage in
            isLoggedIn = false
            Logger.userLog.info("\(successMessage)")
            loginControllerDelegate?.onLogoutSuccess()
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            Logger.userLog.error("\(errorMessage)")
        }
    }
}
