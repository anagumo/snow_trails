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
    
    func open(textMenu: String) {
        while true {
            print(textMenu)
            
            if let adminOption = AdminOption(from: readLine() ?? nil) {
                switch adminOption {
                case .Users:
                    print("Esta funcionalidad no está implementada\n")
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
}
