//
//  App.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation

class App {
    var menuController: MenuController?
    
    init() {
        menuController = MenuController()
    }
    
    deinit {
        menuController = nil
    }
    
    func run() {
        menuController?.displayMainMenu()
    }
}
