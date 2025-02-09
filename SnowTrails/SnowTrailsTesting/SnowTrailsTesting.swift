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
        
        @Test func loginError() async throws {
            let userLoaded = userDataLoader.login(emailInput: "ari@keepcoding.es", passwordInput: "Regularuser2")
            #expect(userLoaded == nil, "It is expected that the user is not in the data source")
        }
        
        @Test func loginSuccess() async throws {
            let userLoaded = userDataLoader.login(emailInput: "regularuser@keepcoding.es", passwordInput: "Regularuser1")
            #expect(userLoaded != nil, "It is expected that the user is in the data source")
        }
        
        @Test func logoutSuccess() async throws {
            guard let userLoggedIn = userDataLoader.login(emailInput: "regularuser@keepcoding.es", passwordInput: "Regularuser1") else {
                return
            }
            guard let userLoggedOut = userDataLoader.logout(userId: userLoggedIn.id) else {
                return
            }
            
            #expect(userLoggedOut.isLoggedIn == false, "It is expected that the user is logged out")
        }
    }
}
