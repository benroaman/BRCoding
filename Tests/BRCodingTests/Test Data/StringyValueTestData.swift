//
//  StringyValueTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct StringyValueTestData {
    private init() { }
    
    static let testInt: Int = 119
    static let intJSON = #"{"testValue":\#(testInt)}"#
    static let intJSONData = intJSON.data(using: .utf8)!
    
    static let stringyIntJSONData = #"{"testValue":"\#(testInt)"}"#.data(using: .utf8)!
    
    static let invalidTypeJSONData = #"{"testValue":"Invalid String"}"#.data(using: .utf8)!
}
