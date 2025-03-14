//
//  BoolTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct BoolTestData {
    private init() { }
    
    static let trueLiteralJSON = #"{"testValue":true}"#.data(using: .utf8)!
    static let trueNumericalJSON = #"{"testValue":1}"#.data(using: .utf8)!
    static let trueStringyBoolJSON = #"{"testValue":"true"}"#.data(using: .utf8)!
    static let trueStringyIntJSON = #"{"testValue":"1"}"#.data(using: .utf8)!
    static let falseLiteralJSON = #"{"testValue":false}"#.data(using: .utf8)!
    static let falseNumericalJSON = #"{"testValue":0}"#.data(using: .utf8)!
    static let falseStringyBoolJSON = #"{"testValue":"false"}"#.data(using: .utf8)!
    static let falseStringyIntJSON = #"{"testValue":"0"}"#.data(using: .utf8)!
    static let invalidStringJSON = #"{"testValue":"Sheboygan, WI"}"#.data(using: .utf8)!
    static let invalidIntJSON = #"{"testValue":19}"#.data(using: .utf8)!
    static let invalidTypeJSON = #"{"testValue":19.19}"#.data(using: .utf8)!
}
