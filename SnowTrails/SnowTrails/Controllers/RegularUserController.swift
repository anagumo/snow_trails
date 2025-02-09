//
//  RegularUserController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

protocol RegularUserControllerImplementation {
    func displayMenu(texMenu: String)
}

class RegularUserController: RegularUserControllerImplementation {
    private var regularUserOption: RegularUserOption?
    
    init() {
        regularUserOption = nil
    }
    
    deinit {
        regularUserOption = nil
    }
    
    func displayMenu(texMenu: String) {
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
                    print("Cerrar sesión")
                }
            } else {
                //TODO: Complementary - Handle Menu error
                print("Opción inválida\n")
            }
        }
    }
}
