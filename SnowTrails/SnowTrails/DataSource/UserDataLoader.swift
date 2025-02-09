//
//  UserDataLoader.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

// To code this clase I followed the instructions on Base Testing project
// It also copy the file into Build Phases to set the subpath
class UserDataLoader {
    var users: [User]
    
    init(from testData: Data? = nil) {
        users = []
        
        guard let loadedUsers = loadUsers(from: testData) else {
            print("Unable to load users in the initializer of UserDataLoader")
            return
        }
        
        users = loadedUsers
    }
    
    private func loadUsers(from testData: Data? = nil) -> [User]? {
        let data: Data
        
        do {
            if let testData {
                data = testData
            } else {
                guard let filepath =  Bundle.main.path(forResource: "users", ofType: "json", inDirectory: "DataSource/users") else {
                    print("Error: No se encontró el archivo users.json en el bundle.")
                    return nil
                }
                
                let url = URL(fileURLWithPath: filepath)
                
                guard FileManager.default.fileExists(atPath: url.path) else {
                    print("Error: No se encontró el archivo users.json en la ruta.")
                    return nil
                }
                
                data = try Data(contentsOf: url)
            }
            
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            return userResponse.users
            
        } catch {
            print("Error al cargar o decodificar users.json: \(error)")
            return nil
        }
    }
    
    func getUser(emailInput: String, passwordInput: String) -> User? {
        users.filter { user in
            user.email == emailInput && user.password == passwordInput
        }.first
    }
    
    func updateUser(_ user: User) {
        users = users.compactMap {
            guard $0.id == user.id else {
                return $0
            }
            
            var user = $0
            user.isLoggedIn.toggle()
            return user
        }
    }
}
