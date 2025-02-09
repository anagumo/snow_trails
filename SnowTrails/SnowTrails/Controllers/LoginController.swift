//
//  LoginController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 07/02/25.
//

import Foundation

protocol LoginControllerImplementation {
    func displayMenu(textMenu: String)
    var loginControllerDelegate: LoginControllerDelegate? { get set }
    var isLoggedIn: Bool { get set }
}

protocol LoginControllerDelegate: AnyObject { // The compiler requieres this protocol (?)
    func onLoginSuccess(user: User)
}

class LoginController: LoginControllerImplementation {
    private let loginService: LoginServiceImplementation
    weak var loginControllerDelegate: LoginControllerDelegate?
    var isLoggedIn: Bool = false
    
    init(loginService: LoginServiceImplementation) {
        self.loginService = loginService
    }
    
    deinit {
        loginControllerDelegate = nil
    }
    
    func displayMenu(textMenu: String) {
        while !isLoggedIn {
            print(textMenu)
            
            if let loginOption = LoginOption(from: readLine() ?? nil) {
                switch loginOption {
                case .LoginUser, .LoginAdmin:
                    login()
                case .Quit:
                    break
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
    
    private func login() {
        // TODO: Complementary - validate user credentials and role
        print("Ingresa tu email: ")
        let emailInput = readLine() ?? ""
        
        print("Ingresa tu contraseña: ")
        let passwordInput = readLine() ?? ""
        
        loginService.login(emailInput: emailInput, passwordInput: passwordInput) { successMessage, user in
            isLoggedIn = user.isLoggedIn
            print(successMessage)
            loginControllerDelegate?.onLoginSuccess(user: user)
        } onError: { errorMessage in
            // TODO: Complemetary - Handle Login error
            print(errorMessage)
        }
    }
}
