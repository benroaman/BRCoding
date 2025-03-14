//
//  StringTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct StringTestData {
    private init() { }
    
    static let validString = "This is a valid string, y'all 🥸"
    static let validStringJSON = #"{"testValue":"\#(validString)"}"#
    static let validStringJSONData = validStringJSON.data(using: .utf8)!

    static let emptyString = ""
    static let emptyStringJSON = #"{"testValue":"\#(emptyString)"}"#
    static let emptyStringJSONData = emptyStringJSON.data(using: .utf8)!

    static let whitespaceString = "  \n "
    static let whitespaceStringJSONData = (try? JSONEncoder().encode(["testValue": whitespaceString]))!
    static let whitespaceStringJSON = String(data: whitespaceStringJSONData, encoding: .utf8)!

    static let invalidTypeJSON = #"{"testValue": 12345}"#
    static let invalidTypeJSONData = invalidTypeJSON.data(using: .utf8)!
}
