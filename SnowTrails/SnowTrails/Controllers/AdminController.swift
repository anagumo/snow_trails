//
//  AdminController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

class AdminController: UserControllerImplementation {
    private let userService: UserService
    weak var loginControllerDelegate: LoginControllerDelegate?
    private var isLoggedIn: Bool
    
    init(userService: UserService) {
        self.userService = userService
        isLoggedIn = false
    }
    
    deinit {
        loginControllerDelegate = nil
    }
    
    func open(textMenu: String, user: User) {
        isLoggedIn = user.isLoggedIn
        
        while isLoggedIn {
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
                    logout(userId: user.id)
                }
            } else {
                // TODO: Complementary - Handle error
                print("Opción inválida\n")
            }
        }
    }
    
    private func getUsers() {
        userService.getAll { users in
            do {
                let usersText = try users.reduce("") {
                    return $0 + (try $1.getDescription()) + "\n"
                }
                print(usersText)
            } catch {
                print(UserError(from: error).errorDescription)
            }
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
    
    func logout(userId: String) {
        userService.logout(userId: userId) { onSuccessMessage in
            isLoggedIn = false
            print(onSuccessMessage)
            loginControllerDelegate?.onLogoutSuccess()
        } onError: { errorMessage in
            // TODO: Complementary - Handle error
            print(errorMessage)
        }
    }
}
