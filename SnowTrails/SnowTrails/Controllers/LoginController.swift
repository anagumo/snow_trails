//
//  LoginController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 07/02/25.
//

import Foundation

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
            print(textMenu)
            
            if let loginOption = LoginOption(from: readLine() ?? nil) {
                switch loginOption {
                case .LoginUser, .LoginAdmin:
                    login()
                case .Quit:
                    quitLogin = true
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
    
    private func login() {
        var emailInput = ""
        
        while  emailInput.isEmpty {
            print("Ingresa tu email: ")
            emailInput = readLine() ?? ""
            
            // TODO: Research to improve the Regex linter.
            // TODO: Should Regex validations be the responsibility of the controller or a service?
            do {
                try RegexLint.validate(data: emailInput, matchWith: .email)
            } catch {
                emailInput.removeAll()
                print(AppError(from: error).errorDescription)
            }
        }
        
        print("Ingresa tu contraseña: ")
        let passwordInput = readLine() ?? ""
        
        loginService.login(emailInput: emailInput, passwordInput: passwordInput) { successMessage, user in
            quitLogin = user.isLoggedIn
            print(successMessage)
            loginControllerDelegate?.onLoginSuccess(user: user)
        } onError: { errorMessage in
            // TODO: Complemetary - Handle Login error
            print(errorMessage)
        }
    }
}
