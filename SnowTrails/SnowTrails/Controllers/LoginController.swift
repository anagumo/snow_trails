//
//  LoginController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 07/02/25.
//

import Foundation
import OSLog

protocol LoginControllerImplementation {
    func open(textMenu: String)
    var loginControllerDelegate: LoginControllerDelegate? { get set }
    var quitLogin: Bool { get set }
}

// User controllers shares this protocol
protocol LoginControllerDelegate: AnyObject { // The compiler requieres this protocol (?)
    func onLoginSuccess(user: User)
    func onLogoutSuccess()
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
            
            do {
                let loginOption = try LoginOption(from: readLine() ?? "")
                switch loginOption {
                case .LoginUser, .LoginAdmin:
                    login()
                case .Quit:
                    quitLogin = true
                }
            } catch {
                guard let appError = error as? AppError else {
                    return Logger.userLog.error("\(AppError.unknown.errorDescription)")
                }
                Logger.userLog.error("\(appError.errorDescription)")
            }
        }
    }
    
    private func login() {
        var emailInput = ""
        while emailInput.isEmpty {
            Logger.userLog.log("Ingresa tu email: ")
            emailInput = readLine() ?? ""
            
            loginService.validate(text: emailInput, regexPattern: .email) {
                emailInput = $0
            } onError: { appError in
                emailInput.removeAll()
                Logger.userLog.error("\(appError.errorDescription)")
            }
        }
        
        Logger.userLog.log("Ingresa tu contraseña: ")
        let passwordInput = readLine() ?? ""
        
        loginService.login(email: emailInput, password: passwordInput) { successMessage, user in
            quitLogin = user.isLoggedIn
            Logger.userLog.info("\(successMessage)")
            loginControllerDelegate?.onLoginSuccess(user: user)
        } onError: { errorMessage in
            // TODO: Complemetary - Handle Login error
            Logger.userLog.error("\(errorMessage)")
        }
    }
}
