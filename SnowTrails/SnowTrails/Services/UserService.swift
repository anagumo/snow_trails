//
//  UserService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 09/02/25.
//

import Foundation

protocol UserServiceImplementation {
    func logout(userId: String, onSuccess: (String) -> (), onError: (String) -> ())
}

class UserService: UserServiceImplementation {
    private let userDataLoader: UserDataLoader
    
    init(userDataLoader: UserDataLoader) {
        self.userDataLoader = userDataLoader
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
