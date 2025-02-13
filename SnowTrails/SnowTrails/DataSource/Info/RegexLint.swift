//
//  RegexPattern.swift
//  SnowTrails
//
//  Created by Ariana Rodríguez on 11/02/25.
//

import Foundation

protocol RegexLintDelegate {
    func validate(text: String, regexPattern: RegexPattern, onSuccess: (String) -> (), onError: (AppError) -> ())
}

enum RegexPattern: String {
    case email = #"^[A-Za-z0-9]+@[a-zA-Z]+\.[es|com]{2,3}$"#
    case username = #"[\w]{8,24}"#
}

struct RegexLint {
    
    static func validate(data: String, matchWith regexPattern: RegexPattern) throws {
        let regex = try Regex(regexPattern.rawValue)
        guard data.contains(regex) else {
            throw AppError(from: regexPattern)
        }
    }
}
