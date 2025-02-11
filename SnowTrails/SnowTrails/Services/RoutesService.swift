//
//  RoutesService.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 10/02/25.
//

import Foundation

protocol RoutesServiceImplementation {
    func getRoutes() -> [Route]
}

class RoutesService: RoutesServiceImplementation {
    private let routesLoader: RoutesLoader
    
    init(routesLoader: RoutesLoader) {
        self.routesLoader = routesLoader
    }
    
    func getRoutes() -> [Route] {
        routesLoader.routes
    }
}
