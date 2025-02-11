//
//  RoutesController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 10/02/25.
//

import Foundation

protocol RoutesControllerImplementation {
    func getRoutes()
}

class RoutesController: RoutesControllerImplementation {
    private let routesService: RoutesService
    
    init(routesService: RoutesService) {
        self.routesService = routesService
    }
    
    func getRoutes() {
        routesService.getRoutes().forEach { route in
            print(route.name)
        }
    }
}
