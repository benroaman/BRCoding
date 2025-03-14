//
//  DateTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct DateTestData {
    private init() { }
    
    static let validDateISO6601 = "1964-09-11T19:15:00-01:00"
    static let validDateJSON = #"{"testValue":"\#(validDateISO6601)"}"#
    static let validDateJSONData = validDateJSON.data(using: .utf8)!
    static let validDateLocalized = (try? Date(validDateISO6601, strategy: .iso8601))!
    static let invalidDateJSON = #"{"testValue":"2025-03-03"}"#
    static let invalidDateJSONData = invalidDateJSON.data(using: .utf8)!
    static let invalidTypeJSON = #"{"testValue":12345}"#
    static let invalidTypeJSONData = invalidTypeJSON.data(using: .utf8)!
}
