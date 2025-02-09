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
    private let users: [User]
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
        users = userDataLoader.users
    }
    
    func getUser(emailInput: String, passwordInput: String, onSuccess: (String, User) -> (), onError: (String) -> ()) {
        guard let user = getUser(emailInput: emailInput, passwordInput: passwordInput) else {
            onError("Ocurrió un error al iniciar sesión.\n")
            return
        }
        
        onSuccess(user.getLoginMessage(), user)
    }
    
    private func getUser(emailInput: String, passwordInput: String) -> User? {
        users.filter { user in
            user.email == emailInput && user.password == passwordInput
        }.first
    }
}
