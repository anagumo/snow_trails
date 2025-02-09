//
//  LoginService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol LoginServiceImplementation {
    func login(emailInput: String, passwordInput: String, onSuccess: (String, User) -> (), onError: (String) -> ())
}

class LoginService: LoginServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func login(emailInput: String, passwordInput: String, onSuccess: (String, User) -> (), onError: (String) -> ()) {
        guard let user = userDataLoader.login(emailInput: emailInput, passwordInput: passwordInput) else {
            onError("Ocurrió un error al iniciar sesión.\n")
            return
        }
        
        onSuccess(user.getLoginMessage(), user)
    }
}
