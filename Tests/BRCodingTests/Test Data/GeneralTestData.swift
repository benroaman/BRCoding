//
//  GeneralTestData.swift
//
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct GeneralTestData {
    private init() { }
    
    static let nullLiteralJSON = #"{"testValue":null}"#
    static let nullLiteralJSONData = nullLiteralJSON.data(using: .utf8)!
    static let missingFieldJSON = #"{}"#
    static let missingFieldJSONData = missingFieldJSON.data(using: .utf8)!
}
