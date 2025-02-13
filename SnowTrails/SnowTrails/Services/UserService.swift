//
//  UserService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 09/02/25.
//

import Foundation
import OSLog

protocol UserServiceImplementation: RegexLintDelegate {
    func getAll(onSuccess: ([User]) -> (), onError: (AppError) -> ())
    func addUser(username: String, email: String, password: String, onSuccess: (String, User) -> (), onError: (AppError) -> ())
    func deleteUser(username: String, onSuccess: (String) -> (), onError: (AppError) -> ())
    func logout(userId: String, onSuccess: (String) -> (), onError: (AppError) -> ())
}

class UserService: UserServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func getAll(onSuccess: ([User]) -> (), onError: (AppError) -> ()) {
        guard !userDataLoader.getAll().isEmpty else {
            Logger.developerLog.error("Error: el programa debe tener al menos dos usuarios por defecto")
            return
        }
        
        onSuccess(userDataLoader.getAll())
    }
    
    func addUser(username: String, email: String, password: String, onSuccess: (String, User) -> (), onError: (AppError) -> ()) {
        guard let user = userDataLoader.add(username: username, email: email, password: password) else {
            onError(AppError.addUser)
            return
        }
        
        onSuccess("Usuario \(user.username) con email \(user.email) añadido satisfactoriamente\n", user)
    }
    
    func deleteUser(username: String, onSuccess: (String) -> (), onError: (AppError) -> ()) {
        guard userDataLoader.delete(username: username) else {
            onError(AppError.deleteUser)
            return
        }
        
        onSuccess("Usuario eliminado satisfactoriamente")
    }
    
    func logout(userId: String, onSuccess: (String) -> (), onError: (AppError) -> ()) {
        guard let user = userDataLoader.logout(userId: userId) else {
            Logger.developerLog.error("Error: no se pudo cerrar la sesión, el usuario no existe en el Loader")
            return
        }
        
        guard !user.isLoggedIn else {
            onError(AppError.logout)
            return
        }
        
        onSuccess("La sesión se ha cerrado satisfactoriamente")
    }
    
    
    // MARK: RegexLint delegate functions
    func validate(text: String, regexPattern: RegexPattern, onSuccess: (String) -> (), onError: (AppError) -> ()) {
        do {
            try RegexLint.validate(data: text, matchWith: regexPattern)
            onSuccess(text)
        } catch {
            guard let appError = error as? AppError else {
                onError(AppError.unknown)
                return
            }
            
            onError(appError)
        }
    }
}
