//
//  LoginService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol LoginServiceImplementation: RegexLintDelegate {
    func login(email: String, password: String, onSuccess: (String, User) -> (), onError: (String) -> ())
}

class LoginService: LoginServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func login(email: String, password: String, onSuccess: (String, User) -> (), onError: (String) -> ()) {
        guard let user = userDataLoader.login(email: email, password: password) else {
            onError("Ocurrió un error al iniciar sesión.\n")
            return
        }
        
        onSuccess(user.getLoginMessage(), user)
    }
    
    func validate(text: String, regexPattern: RegexPattern, onSuccess: (String) -> (), onError: (AppError) -> ()) {
        do {
            try RegexLint.validate(data: text, matchWith: regexPattern)
            onSuccess(text)
        } catch {
            guard let appError = error as? AppError else {
                return onError(AppError.unknown)
            }
            
            onError(appError)
        }
    }
}
