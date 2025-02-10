//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol RegularUserControllerImplementation {
    func displayMenu(texMenu: String, user: User)
    var regularUserControllerDelegate: RegularUserControllerDelegate? { get set }
}

protocol RegularUserControllerDelegate: AnyObject {
    func onLogoutSuccess()
}

class RegularUserController: RegularUserControllerImplementation {
    private var userService: UserService
    weak var regularUserControllerDelegate: RegularUserControllerDelegate?
    private var isLoggedIn: Bool = true
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    deinit {
        regularUserControllerDelegate = nil
    }
    
    func displayMenu(texMenu: String, user: User) {
        isLoggedIn = user.isLoggedIn
        
        while isLoggedIn {
            print(texMenu)
            
            if let regularUserOption = RegularUserOption(from: readLine() ?? nil) {
                switch regularUserOption {
                case .Routes:
                    print("Ver rutas")
                case .ShortRoute:
                    print("Esta funcionalidad no está implementada")
                case .Logout:
                    userService.logout(userId: user.id) { onSuccessMessage in
                        isLoggedIn = false
                        print(onSuccessMessage)
                        regularUserControllerDelegate?.onLogoutSuccess()
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
