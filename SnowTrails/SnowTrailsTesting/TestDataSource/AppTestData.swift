//
//  UserTestData.swift
//  SnowTrailsTesting
//
//  Created by Ariana Rodríguez on 08/02/25.
//

import Foundation

struct UserTestData {
    
    static func givenTwoUsers() -> Data? {
        return
"""
{
  "users": [
    {
      "id": "1",
      "username": "Regularuserkeepcoding1",
      "email": "regularuser@keepcoding.es",
      "password": "Regularuser1",
      "role": "regular",
      "isLoggedIn": false
    },
    {
      "id": "2",
      "username": "Adminuserkeepcoding1",
      "email": "adminuser@keepcoding.es",
      "password": "Adminuser1",
      "role": "admin",
      "isLoggedIn": false
    }
  ]
}
""".data(using: .utf8)
    }
}

struct RouteTestData {
    
    static func givenTwoRoutes() -> Data? {
        return
"""
{
    "routes": [
        {
            "id": "6",
            "name": "Ruta del Refugio Aislado",
            "points": [
                {
                    "id" : "11",
                    "name": "Refugio Aislado",
                    "latitude": 46.0000,
                    "longitude": 7.4000,
                    "altitude": 1400.0
                }
            ]
        },
        {
            "id": "7",
            "name": "Ruta Alpina",
            "points": [
                {
                    "id" : "1",
                    "name": "Alpina Grande",
                    "latitude": 46.0000,
                    "longitude": 7.5000,
                    "altitude": 1500.0
                },
                {
                    "id" : "2",
                    "name": "Alpina Pequeña",
                    "latitude": 46.0022,
                    "longitude": 7.5200,
                    "altitude": 1200.0
                }
            ]
        }
    ]
}
""".data(using: .utf8)
    }
}
