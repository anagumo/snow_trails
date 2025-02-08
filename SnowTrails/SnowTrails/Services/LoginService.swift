//
//  LoginService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol LoginServiceImplementation {
    func getUser(emailInput: String, passwordInput: String, onSuccess: (String) -> (), onError: (String) -> ())
}

class LoginService: LoginServiceImplementation {
    
    func getUser(emailInput: String, passwordInput: String, onSuccess: (String) -> (), onError: (String) -> ()) {
        let regularUser = User(id: "1",
                               username: "Regularuserkeepcoding1",
                               email: "regularuser@keepcoding.es",
                               password: "Regularuser1",
                               role: .regular,
                               isLogged: false)
        
        guard emailInput == regularUser.email && passwordInput == regularUser.password else {
            onError("Ocurrió un error al iniciar sesión.\n")
            return
        }
        
        onSuccess("Has iniciado sesión correctamente como \(regularUser.username).\n")
    }
}
