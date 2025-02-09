//
//  LoginService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol LoginServiceImplementation {
    func getUser(emailInput: String, passwordInput: String, onSuccess: (String, User) -> (), onError: (String) -> ())
}

class LoginService: LoginServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func getUser(emailInput: String, passwordInput: String, onSuccess: (String, User) -> (), onError: (String) -> ()) {
        guard let user = userDataLoader.getUser(emailInput: emailInput, passwordInput: passwordInput) else {
            onError("Ocurrió un error al iniciar sesión.\n")
            return
        }
        
        userDataLoader.updateUser(user)
        onSuccess(user.getLoginMessage(), user)
    }
}
