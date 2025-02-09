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
    private var regularUserOption: RegularUserOption?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    deinit {
        regularUserControllerDelegate = nil
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
