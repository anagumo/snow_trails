//
//  LoggerExtended.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 12/02/25.
//

import Foundation
import OSLog

extension Logger {
    static let userLog = Logger(subsystem: "SnowTrails", category: "UserLogs")
    static let developerLog = Logger(subsystem: "SnowTrails", category: "DeveloperLogs")
}
