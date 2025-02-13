//
//  RouteLoader.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 10/02/25.
//

import Foundation
import OSLog

class RoutesLoader {
    var routes: [Route]
    
    init(from testData: Data? = nil) {
        routes = []
        
        guard let loadedRoutes = loadRoutes(from: testData) else {
            Logger.developerLog.error("Unable to load routes in the initializer of RoutesLoader")
            return
        }
        
        routes = loadedRoutes
    }
    
    private func loadRoutes(from testData: Data? = nil) -> [Route]? {
        let data: Data
        
        do {
            if let testData {
                data = testData
            } else {
                guard let filePath = Bundle.main.path(forResource: "routes", ofType: "json", inDirectory: "DataSource/resources") else {
                    Logger.developerLog.error("Error: No se encontró el archivo routes.json en el bundle.")
                    return nil
                }
                
                let url = URL(fileURLWithPath: filePath)
                
                guard FileManager.default.fileExists(atPath: url.path) else {
                    Logger.developerLog.error("Error: No se encontró el archivo routes.json en la ruta.")
                    return nil
                }
                
                data = try Data(contentsOf: url)
            }
            
            let decoder = JSONDecoder()
            let routesResponse = try decoder.decode(RoutesResponse.self, from: data)
            return routesResponse.routes
        } catch {
            Logger.developerLog.error("Error al cargar o decodificar routes.json: \(error)")
            return nil
        }
    }
}
