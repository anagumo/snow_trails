//
//  LoggerExtended.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 12/02/25.
//

import Foundation
import OSLog

extension Logger {
    // I created two categories to display logs to devs and users
    static let userLog = Logger(subsystem: "SnowTrails", category: "UserLogs")
    static let developerLog = Logger(subsystem: "SnowTrails", category: "DeveloperLogs")
}
