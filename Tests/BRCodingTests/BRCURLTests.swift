//
//  BRCURLTests.swift
//  
//
//  Created by Ben Roaman on 3/13/25.
//

import XCTest
@testable import BRCoding

final class BRCURLTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Data
    private let validURLString = "https://github.com/"
    private lazy var validURLJSON = #"{"testValue":"\#(validURLString)"}"#
    private lazy var validURLJSONData = validURLJSON.data(using: .utf8)!
    private lazy var invalidURLJSONData = #"{"testValue":"\#(validURLString)unescaped spaces"}"#.data(using: .utf8)!
    private lazy var invalidTypeJSONData = #"{"testValue":12345}"#.data(using: .utf8)!
    private let nullLiteralJSON = #"{"testValue":null}"#
    private lazy var nullLiteralJSONData = nullLiteralJSON.data(using: .utf8)!
    private let missingFieldJSON = #"{}"#
    private lazy var missingFieldJSONData = missingFieldJSON.data(using: .utf8)!
    
}
