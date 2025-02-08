//
//  LoginController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 07/02/25.
//

import Foundation

protocol LoginControllerImplementation {
    func displayMenu(textMenu: String)
}

class LoginController: LoginControllerImplementation {
    private let loginService: LoginServiceImplementation
    private var loginOption: LoginOption?
    
    init(loginService: LoginServiceImplementation) {
        self.loginService = loginService
        loginOption = nil
    }
    
    deinit {
        loginOption = nil
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
        
        loginService.getUser(emailInput: emailInput, passwordInput: passwordInput) { userMessage in
            print(userMessage)
        } onError: { errorMessage in
            // TODO: Complemetary - Handle Login error
            print(errorMessage)
        }
    }
}
