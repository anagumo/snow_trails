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
}

protocol LoginControllerDelegate: AnyObject { // The compiler requieres this protocol (?)
    func onLoginSuccess(user: User)
}

class LoginController: LoginControllerImplementation {
    private let loginService: LoginServiceImplementation
    weak var loginControllerDelegate: LoginControllerDelegate?
    private var loginOption: LoginOption?
    
    init(loginService: LoginServiceImplementation) {
        self.loginService = loginService
        loginOption = nil
    }
    
    deinit {
        loginOption = nil
        loginControllerDelegate = nil
    }
    
    func displayMenu(textMenu: String) {
        while loginOption != .Quit {
            print(textMenu)
            
            if let loginOption = LoginOption(from: readLine() ?? nil) {
                self.loginOption = loginOption
                
                switch loginOption {
                case .LoginUser, .LoginAdmin:
                    getUser()
                case .Quit:
                    break
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
    
    private func getUser() {
        // TODO: Complementary - validate user credentials and role
        print("Ingresa tu email: ")
        let emailInput = readLine() ?? ""
        
        print("Ingresa tu contraseña: ")
        let passwordInput = readLine() ?? ""
        
        loginService.getUser(emailInput: emailInput, passwordInput: passwordInput) { successMessage, user in
            print(successMessage)
            loginControllerDelegate?.onLoginSuccess(user: user)
            loginOption = .Quit
        } onError: { errorMessage in
            // TODO: Complemetary - Handle Login error
            print(errorMessage)
        }
    }
}
