//
//  UserDataLoader.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation
import OSLog

// To code this clase I followed the instructions on Base Testing project
// It also copy the file into Build Phases to set the subpath
class UserDataLoader {
    var users: [User]
    
    init(from testData: Data? = nil) {
        users = []
        
        guard let loadedUsers = loadUsers(from: testData) else {
            Logger.developerLog.error("Unable to load users in the initializer of UserDataLoader")
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
                guard let filepath =  Bundle.main.path(forResource: "users", ofType: "json", inDirectory: "DataSource/resources") else {
                    Logger.developerLog.error("Error: No se encontró el archivo users.json en el bundle.")
                    return nil
                }
                
                let url = URL(fileURLWithPath: filepath)
                
                guard FileManager.default.fileExists(atPath: url.path) else {
                    Logger.developerLog.error("Error: No se encontró el archivo users.json en la ruta.")
                    return nil
                }
                
                data = try Data(contentsOf: url)
            }
            
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            return userResponse.users
            
        } catch {
            Logger.developerLog.error("Error al cargar o decodificar users.json: \(error)")
            return nil
        }
    }
    
    /// Updates the user's session to true
    /// - Parameters:
    ///   - email: a text of type (`String`) that represent the email of the user
    ///   - password: a text of type (`String`) that represent the password of the user
    /// - Returns: an optional, if the user is found in the loader the function returns a (`User`), else returns nil
    func login(email: String, password: String) -> User? {
        updateSession {
            $0.email == email && $0.password == password
        } completion: {
            $0.isLoggedIn
        }
    }
    
    /// Updates the user's session to false
    /// - Parameter userId: a text of type (`String`) that represent the id of the user
    /// - Returns: an optional, if the user is found in the loader the function returns a (`User`), else returns nil
    func logout(userId: String) -> User? {
        updateSession {
            $0.id == userId
        } completion: {
            $0.id == userId
        }
    }
    
    // I created a closure that is used by both the login and logout functions
    private func updateSession(predicate: (User) -> Bool, completion: (User) -> Bool) -> User? {
        users = users.compactMap {
            guard predicate($0) else {
                return $0
            }
            
            var user = $0
            user.isLoggedIn.toggle()
            return user
        }
        
        return users.first {
            completion($0)
        }
    }
    
    func getAll() -> [User] {
        users
    }
    
    /// Creates a user in the loader
    /// - Parameters:
    ///   - username: a text of type (`String`) that represent the username of the user
    ///   - email: a text of type (`String`) that represent the email of the user
    ///   - password: a test of type (`String`) that represent the password of the user
    /// - Returns: an optional, if the user is found in the loader the function returns a (`User`); otherwise, returns nil
    func add(username: String, email: String, password: String) -> User? {
        guard let lastUserId = Int(users.last?.id ?? "") else {
            return nil
        }
        let userId = String(lastUserId + 1)
        let user = User(id: userId, username: username, email: email, password: password, role: .regular, isLoggedIn: false)
        users.append(user)
        
        return user
    }
    
    /// Deletes a user in the loader
    /// - Parameter username: a text of type (`String`) that represent the username of the user
    /// - Returns: A boolean: is true if the loader contains the user and is deleted; otherwise, it returns false
    func delete(username: String) -> Bool {
        let hasUser = users.contains { user in
            user.username == username
        }
        
        guard hasUser else {
            return hasUser
        }
        
        users.removeAll { user in
            user.username == username
        }
        
        return hasUser
    }
}
