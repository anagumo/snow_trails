//
//  AdminController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

protocol AdminControllerImplementation {
    func open(textMenu: String)
}

class AdminController: AdminControllerImplementation {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func open(textMenu: String) {
        while true {
            print(textMenu)
            
            if let adminOption = AdminOption(from: readLine() ?? nil) {
                switch adminOption {
                case .Users:
                    getUsers()
                case .AddUser:
                    addUser()
                case .DeleteUser:
                    deleteUser()
                case .AddPointToRoute:
                    print("Esta funcionalidad no está implementada\n")
                case .Logout:
                    print("Esta funcionalidad no está implementada\n")
                }
            } else {
                // TODO: Complementary - Handle error
                print("Opción inválida\n")
            }
        }
    }
    
    private func getUsers() {
        userService.getAll { users in
            let usersText = users.reduce("") {
                $0 + $1.getDescription() + "\n"
            }
            print(usersText)
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            print(errorMessage)
        }
    }
    
    private func addUser() {
        print("Introduce el nombre del usuario que quieres añadir")
        let username = readLine() ?? ""
        print("Introduce el email del usuario que quieres añadir")
        let email = readLine() ?? ""
        print("Introduce la contraseña del usuario que quieres añadir")
        let password = readLine() ?? ""
        
        userService.addUser(username: username, email: email, password: password) { user in
            print(user.getAddUserMessage())
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            print(errorMessage)
        }
    }
    
    private func deleteUser() {
        print("Introduce el nombre del usuario que quieras eliminar")
        let username = readLine() ?? ""
        
        userService.deleteUser(username: username) {
            print("Usuario eliminado satisfactoriamente\n")
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            print(errorMessage)
        }
    }
}
