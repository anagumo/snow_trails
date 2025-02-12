//
//  RegexPattern.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

enum RegexPattern: String {
    case email = #"^[\w]+@[a-zA-Z]+\.[es|com]{2,3}$"#
    case username = #"[\w]{8,24}"#
}

struct RegexLint {
    
    static func validate(data: String, matchWith regexPattern: RegexPattern) throws -> Bool {
        let regex = try Regex(regexPattern.rawValue)
        guard data.contains(regex) else {
            throw AppError(from: regexPattern)
        }
        return true
    }
}
