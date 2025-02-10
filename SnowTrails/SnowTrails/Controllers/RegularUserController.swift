//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol RegularUserControllerImplementation {
    func open(texMenu: String, user: User)
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
    
    func open(texMenu: String, user: User) {
        isLoggedIn = user.isLoggedIn
        
        while isLoggedIn {
            print(texMenu)
            
            if let regularUserOption = RegularUserOption(from: readLine() ?? nil) {
                switch regularUserOption {
                case .Routes:
                    // TODO: Implement routes controller
                    break
                case .ShortRoute:
                    print("Esta funcionalidad no está implementada")
                case .Logout:
                    logout(userId: user.id)
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
    
    private func logout(userId: String) {
        userService.logout(userId: userId) { onSuccessMessage in
            isLoggedIn = false
            print(onSuccessMessage)
            regularUserControllerDelegate?.onLogoutSuccess()
        } onError: { errorMessage in
            print(errorMessage)
        }
    }
}
