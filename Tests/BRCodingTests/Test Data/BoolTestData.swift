//
//  BoolTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct BoolTestData {
    private init() { }
    
    static let trueLiteralJSON = #"{"testValue":true}"#
    static let trueLiteralJSONData = trueLiteralJSON.data(using: .utf8)!
    static let trueIntJSONData = #"{"testValue":1}"#.data(using: .utf8)!
    static let trueStringyBoolJSONData = #"{"testValue":"true"}"#.data(using: .utf8)!
    static let trueStringyIntJSONData = #"{"testValue":"1"}"#.data(using: .utf8)!
    static let falseLiteralJSON = #"{"testValue":false}"#
    static let falseLiteralJSONData = falseLiteralJSON.data(using: .utf8)!
    static let falseIntJSONData = #"{"testValue":0}"#.data(using: .utf8)!
    static let falseStringyBoolJSONData = #"{"testValue":"false"}"#.data(using: .utf8)!
    static let falseStringyIntJSONData = #"{"testValue":"0"}"#.data(using: .utf8)!
    static let invalidStringJSONData = #"{"testValue":"Sheboygan, WI"}"#.data(using: .utf8)!
    static let invalidIntJSONData = #"{"testValue":19}"#.data(using: .utf8)!
    static let invalidTypeJSONData = #"{"testValue":19.19}"#.data(using: .utf8)!
}
