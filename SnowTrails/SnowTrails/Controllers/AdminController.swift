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
                    print("Esta funcionalidad no está implementada\n")
                case .DeleteUser:
                    print("Esta funcionalidad no está implementada\n")
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
}
