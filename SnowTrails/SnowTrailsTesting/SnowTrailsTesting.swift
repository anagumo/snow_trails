//
//  SnowTrailsTesting.swift
//  SnowTrailsTesting
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation
import Testing

class SnowTrailsTesting {
    
    @Suite("Login Tests")
    class LoginTests {
        var testData: Data?
        let userDataLoader: UserDataLoader
        
        init() {
            testData = UserTestData.givenTwoUsers() ?? "".data(using: .utf8)!
            userDataLoader = UserDataLoader(from: testData)
        }
        
        deinit {
            testData = nil
        }
        
        @Test func getUserError() async throws {
            let userLoaded = userDataLoader.getUser(emailInput: "ari@keepcoding.es", passwordInput: "Regularuser2")
            #expect(userLoaded == nil, "It is expected that the user is not in the data source")
        }
        
        @Test func getUserSuccess() async throws {
            let userLoaded = userDataLoader.getUser(emailInput: "regularuser@keepcoding.es", passwordInput: "Regularuser1")
            #expect(userLoaded != nil, "It is expected that the user is in the data source")
        }
        
        @Test func updateUserSession() async throws {
            guard let userLoaded = userDataLoader.getUser(emailInput: "regularuser@keepcoding.es", passwordInput: "Regularuser1") else {
                return
            }
            
            userDataLoader.updateUser(userLoaded)
            
            guard let userUpdated = userDataLoader.getUser(emailInput: "regularuser@keepcoding.es", passwordInput: "Regularuser1") else {
                return
            }
            
            #expect(userUpdated.isLoggedIn, "It is expected that the user is logged in")
        }
    }
}
