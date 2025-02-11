//
//  UserService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 09/02/25.
//

import Foundation

protocol UserServiceImplementation {
    func getAll(onSuccess: ([User]) -> (), onError: (String) -> ())
    func addUser(username: String, email: String, password: String, onSuccess: (User) -> (), onError: (String) -> ())
    func logout(userId: String, onSuccess: (String) -> (), onError: (String) -> ())
}

class UserService: UserServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
    }
    
    func getAll(onSuccess: ([User]) -> (), onError: (String) -> ()) {
        guard !userDataLoader.getAll().isEmpty else {
            return onError("No se encontraron usuarios en la base de datos")
        }
        
        onSuccess(userDataLoader.getAll())
    }
    
    func addUser(username: String, email: String, password: String, onSuccess: (User) -> (), onError: (String) -> ()) {
        guard let userAdded = userDataLoader.add(name: username, email: email, password: password) else {
            return onError("Ocurrió un error al agregar el usuario")
        }
        
        onSuccess(userAdded)
    }
    
    func logout(userId: String, onSuccess: (String) -> (), onError: (String) -> ()) {
        guard let user = userDataLoader.logout(userId: userId) else {
            return onError("No se encontró el usuario\n")
        }
        
        guard !user.isLoggedIn else {
            return onError("Ocurrió un error al cerrar la sesión\n")
        }
        
        onSuccess("La sesión se ha cerrado correctamente\n")
    }
}
