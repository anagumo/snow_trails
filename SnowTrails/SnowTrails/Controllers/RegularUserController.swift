//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol RegularUserControllerImplementation {
    func displayMenu(texMenu: String, user: User)
}

class RegularUserController: RegularUserControllerImplementation {
    private var userService: UserService
    private var regularUserOption: RegularUserOption?
    
    init(userService: UserService) {
        self.userService = userService
        regularUserOption = nil
    }
    
    deinit {
        regularUserOption = nil
    }
    
    func displayMenu(texMenu: String, user: User) {
        while regularUserOption == nil {
            print(texMenu)
            
            if let regularUserOption = RegularUserOption(from: readLine() ?? nil) {
                self.regularUserOption = regularUserOption
                
                switch regularUserOption {
                case .Routes:
                    print("Ver rutas")
                case .ShortRoute:
                    print("Esta funcionalidad no está implementada")
                case .Logout:
                    userService.logout(userId: user.id) { onSuccessMessage in
                        print(onSuccessMessage)
                    } onError: { errorMessage in
                        print(errorMessage)
                    }
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
}
