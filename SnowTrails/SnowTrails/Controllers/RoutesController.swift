//
//  RoutesController.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 10/02/25.
//

import Foundation
import OSLog

protocol RoutesControllerImplementation {
    func getRoutes()
}

class RoutesController: RoutesControllerImplementation {
    private let routesService: RoutesService
    
    init(routesService: RoutesService) {
        self.routesService = routesService
    }
    
    func getRoutes() {
        let routesFormatted = getRoutesFormatted()
        Logger.userLog.log("\(routesFormatted)")
    }
    
    private func getRoutesFormatted() -> String {
        routesService.getRoutes()
            .reduce("") {
                $0 + $1.getDescription() + "\n"
            }
    }
}
