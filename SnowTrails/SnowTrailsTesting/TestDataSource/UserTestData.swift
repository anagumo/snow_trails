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
