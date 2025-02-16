//
//  LoginController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 07/02/25.
//

import Foundation
import OSLog


// User controllers shares this protocol
protocol LoginControllerDelegate: AnyObject { // The compiler requieres this protocol (?)
    func onLoginSuccess(user: User)
    func onLogoutSuccess()
}

protocol LoginControllerImplementation {
    func open(textMenu: String)
    var loginControllerDelegate: LoginControllerDelegate? { get set }
    var quitLogin: Bool { get set }
}

class LoginController: LoginControllerImplementation {
    private let loginService: LoginServiceImplementation
    weak var loginControllerDelegate: LoginControllerDelegate?
    var quitLogin: Bool = false
    
    init(loginService: LoginServiceImplementation) {
        self.loginService = loginService
    }
    
    deinit {
        loginControllerDelegate = nil
    }
    
    func open(textMenu: String) {
        while !quitLogin {
            Logger.userLog.log("\(textMenu)")
            
            // Creates the LoginOption and handles the error
            do {
                let loginOption = try LoginOption(from: readLine() ?? "")
                switch loginOption {
                case .loginUser, .loginAdmin:
                    login()
                case .quit:
                    quitLogin = true
                }
            } catch let error as AppError {
                Logger.userLog.error("\(error.errorDescription)")
            } catch {
                Logger.userLog.error("\(AppError.unknown.errorDescription)")
            }
        }
    }
    
    private func login() {
        var emailInput = ""
        while emailInput.isEmpty {
            Logger.userLog.log("Ingresa tu email: ")
            emailInput = readLine() ?? ""
            
            // Validates the email regex pattern
            loginService.validate(text: emailInput, regexPattern: .email) {
                emailInput = $0
            } onError: { appError in
                emailInput.removeAll()
                Logger.userLog.error("\(appError.errorDescription)")
            }
        }
        
        Logger.userLog.log("Ingresa tu contraseña: ")
        let passwordInput = readLine() ?? ""
        
        // After the data is validated, the login is performed
        loginService.login(email: emailInput, password: passwordInput) { successMessage, user in
            quitLogin = user.isLoggedIn
            Logger.userLog.info("\(successMessage)")
            loginControllerDelegate?.onLoginSuccess(user: user)
        } onError: { appError in
            Logger.userLog.error("\(appError.errorDescription)")
        }
    }
}
