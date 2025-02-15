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

struct Point: Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let altitude: Double
}

struct Route: Codable {
    let id: String
    let name: String
    let points: [Point]
    
    func getDescription() -> String {
        "\(name) - \(String(format: "%.2f", getDistance())) Km"
    }
    
    // Calculate sum of distances using de Euclidean formula considering the conversion of radians to kilometers
    func getDistance() -> Double {
        guard points.count > 1 else {
            return 0
        }
        
        var prevPoint = points[0] // Considers the first item in the array as the starting point
        let latToKm = 111.32 // 1 degree of latitude is equal to 111.32 Kms
        
        return points.dropFirst().reduce(0) {
            let lonToKm = latToKm * cos(((prevPoint.latitude + $1.latitude) / 2) * .pi / 180) // Kms per degree of longitude
            let sum = $0 + sqrt(pow(($1.latitude - prevPoint.latitude) * latToKm, 2) + pow(($1.longitude - prevPoint.longitude) * lonToKm, 2))
            prevPoint = $1
            return sum // returns the sum of the distances between the previous point and the current point.
        }
    }
}
