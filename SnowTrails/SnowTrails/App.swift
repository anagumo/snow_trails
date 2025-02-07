//
//  App.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class App {
    let menuController: MenuController
    
    init() {
        menuController = MenuController()
    }
    
    func run() {
        menuController.displayMenu(.Login)
    }
}
