//
//  LoginError.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

enum UserError: Error, LocalizedError {
    case role
    case unknown
    
    init(from error: Error) {
        guard let error = error as? UserError else {
            self = .unknown
            return
        }
        self = error
    }
    
    var errorDescription: String {
        switch self {
        case .role:
            return "Error: No se pudo obtener el rol del usuario"
        case .unknown:
            return "Error: Ocurrió un error desconocido"
        }
    }
}
