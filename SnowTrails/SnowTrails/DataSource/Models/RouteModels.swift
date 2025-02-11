//
//  GeographicPoint.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 10/02/25.
//

import Foundation

struct RoutesResponse: Codable {
    let routes: [Route]
}

struct GeographicPoint: Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let altitude: Double
}

struct Route: Codable {
    let id: String
    let name: String
    let points: [GeographicPoint]
    
    func description() -> String {
        "\(name) - \(getKms()) Km"
    }
    
    func getKms() -> Double {
        guard points.count > 1 else {
            return 0
        }
        
        return points.reduce(0) { partialResult, point in
            // TODO: Replace by the sum of distances between each point
            partialResult + point.latitude
        }
    }
}
