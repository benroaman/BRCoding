//
//  DateTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct DateTestData {
    private init() { }
    
    static let wootenISO6601 = "1964-09-11T19:15:00-01:00"
    static let wootenJSON = #"{"testValue":"\#(wootenISO6601)"}"#
    static let wootenJSONData = wootenJSON.data(using: .utf8)!
    static let localizedWootenDate = (try? Date(wootenISO6601, strategy: .iso8601))!
    static let yesterday = Date().addingTimeInterval(-24*60*60)
    static let yesterdayEpoch = yesterday.timeIntervalSince1970.rounded(.towardZero)
    static let yesterdayJSON = #"{"testValue":"\#(yesterday.ISO8601Format())"}"#
    static let yesterdayJSONData = yesterdayJSON.data(using: .utf8)!
    static let invalidDateJSON = #"{"testValue":"2025-03-03"}"#
    static let invalidDateJSONData = invalidDateJSON.data(using: .utf8)!
    static let invalidTypeJSON = #"{"testValue":12345}"#
    static let invalidTypeJSONData = invalidTypeJSON.data(using: .utf8)!
}
