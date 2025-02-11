//
//  SnowTrailsTesting.swift
//  SnowTrailsTesting
//
//  Created by Ariana Rodríguez on 06/02/25.
//

import Foundation
import Testing

class SnowTrailsTesting {
    
    @Suite("Login")
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
    }
    
    @Suite("Routes")
    class RouteTests {
        var testData: Data?
        var routes: [Route]
        
        init() {
            testData = RouteTestData.givenTwoRoutes() ?? "".data(using: .utf8)!
            routes = RoutesLoader(from: testData).routes
        }
        
        deinit {
            testData = nil
            routes = []
        }
        
        @Test func getRoutesCount() async throws {
            #expect(routes.count == 2, "It is expected that returns two elements")
        }
        
        @Test func getDistanceEqualToZero() async throws {
            let distance = routes.first?.getDistance()
            #expect(distance == 0, "It is expected that the distance is 0 Km")
        }
        
        @Test func getDistanceGreaterThanZero() async throws {
            let formattedDistance = String(format: "%.2f", routes.last?.getDistance() ?? .zero)
            #expect(formattedDistance == "1.57", "It is expected that the distance is greater than 0 km")
        }
        
        @Test func getRouteDescription() async throws {
            let routeDescription = routes.first?.getDescription()
            #expect(routeDescription == "Ruta del Refugio Aislado - 0.00 Km",
                    "It is expected that returns the formatted route's description")
        }
    }
    
    @Suite("Users")
    class UsersTests {
        var testData: Data?
        let userDataLoader: UserDataLoader
        
        init() {
            testData = UserTestData.givenTwoUsers() ?? "".data(using: .utf8)!
            userDataLoader = UserDataLoader(from: testData)
        }
        
        deinit {
            testData = nil
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
        
        @Test func getUsers() async throws {
            #expect(userDataLoader.getAll().count == 2, "It is expected to return 2 users")
        }
        
        @Test func addUserSuccess() async throws {
            let userAdded = userDataLoader.add(username: "Regularuserkeepcoding2", email: "regularuser2@keepcoding.es", password: "Regularuser2")
            let userFound = userDataLoader.users.filter {
                $0.username == userAdded?.username
            }.first
            
            #expect(userFound?.id == "3", "It is expected the user id is the last one more one")
        }
        
        @Test func deleteUserSuccess() async throws {
            let userAdded = userDataLoader.add(username: "Regularuserkeepcoding2", email: "regularuser2@keepcoding.es", password: "Regularuser2")
            let isDeletionSuccess = userDataLoader.delete(username: userAdded?.username ?? "")
            
            #expect(isDeletionSuccess, "It is expected to return true since there was a user in the loader")
            #expect(userDataLoader.users.count == 2, "It is expected to return 2 users after deletion")
        }
        
        @Test func deleteUserError() async throws {
            let isDeletionSuccess = userDataLoader.delete(username: "AriKeepCoder")
            
            #expect(!isDeletionSuccess, "It is expected to return false since there is no a user in the loader")
        }
    }
}
