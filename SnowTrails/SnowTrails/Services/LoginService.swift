//
//  LoginService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol LoginServiceImplementation {
    func validateEmailInput(onSuccess: (String) -> (), onError: (AppError) -> ())
    func login(email: String, password: String, onSuccess: (String, User) -> (), onError: (String) -> ())
}

class LoginService: LoginServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func validateEmailInput(onSuccess: (String) -> (), onError: (AppError) -> ()) {
        var email = ""
        while email.isEmpty {
            print("Ingresa tu email: ")
            email = readLine() ?? ""
            
            // TODO: Research to improve the Regex linter.
            do {
                try RegexLint.validate(data: email, matchWith: .email)
            } catch {
                email.removeAll()
                onError(AppError.email)
            }
        }
        
        onSuccess(email)
    }
    
    func login(email: String, password: String, onSuccess: (String, User) -> (), onError: (String) -> ()) {
        guard let user = userDataLoader.login(email: email, password: password) else {
            onError("Ocurrió un error al iniciar sesión.\n")
            return
        }
        
        onSuccess(user.getLoginMessage(), user)
    }
}
