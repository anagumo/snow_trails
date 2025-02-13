//
//  LoginService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation
import OSLog

protocol LoginServiceImplementation: RegexLintDelegate {
    func login(email: String, password: String, onSuccess: (String, User) -> (), onError: (AppError) -> ())
}

class LoginService: LoginServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func login(email: String, password: String, onSuccess: (String, User) -> (), onError: (AppError) -> ()) {
        guard let user = userDataLoader.login(email: email, password: password) else {
            onError(AppError.login)
            return
        }
        
        guard let role = user.role else {
            Logger.developerLog.error("Error: ocurrió un error al obtener el rol del usuario")
            return
        }
        
        onSuccess("Has iniciado sesión satisfactoriamente como usuario \(role)\n", user)
    }
    
    // MARK: RegexLint delegate functions
    func validate(text: String, regexPattern: RegexPattern, onSuccess: (String) -> (), onError: (AppError) -> ()) {
        do {
            try RegexLint.validate(data: text, matchWith: regexPattern)
            onSuccess(text)
        } catch let error as AppError {
            return onError(error)
        } catch {
            return onError(AppError.unknown)
        }
    }
}
