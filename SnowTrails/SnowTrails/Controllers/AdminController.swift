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
        print(textMenu)
    }
}
