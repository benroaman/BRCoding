//
//  BRCDateTests.swift
//
//
//  Created by Ben Roaman on 3/11/25.
//

import XCTest
@testable import BRCoding

final class BRCStringTests: XCTestCase {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Values
    let validString = "This is a valid string, y'all 🥸"
    private lazy var validStringJSON = #"{"someString":"\#(validString)"}"#
    private lazy var validStringJSONData = validStringJSON.data(using: .utf8)!
    
    let emptyString = ""
    private lazy var emptyStringJSON = #"{"someString":"\#(emptyString)"}"#
    private lazy var emptyStringJSONData = emptyStringJSON.data(using: .utf8)!
    
    let whitespaceString = "   "
    private lazy var whitespaceStringJSON = #"{"someString":"\#(whitespaceString)"}"#
    private lazy var whitespaceStringJSONData = whitespaceStringJSON.data(using: .utf8)!
    
    private let nullLiteralJSON = #"{"someString":null}"#
    private lazy var nullLiteralJSONData = nullLiteralJSON.data(using: .utf8)!
    
    private let missingFieldJSON = #"{}"#
    private lazy var missingFieldJSONData = missingFieldJSON.data(using: .utf8)!
    
    private let invalidTypeJSON = #"{"someString": 12345}"#
    private lazy var invalidTypeJSONData = invalidTypeJSON.data(using: .utf8)!
    
    // MARK: Optional
    private struct OptionalString: Codable {
        @BRCStringOptional private(set) var someString: String?
    }
    
    func testOptional() {
        if let validStringTestObject = try? decoder.decode(OptionalString.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.someString == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(OptionalString.self, from: encoded) {
                    XCTAssert(decoded.someString == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(OptionalString.self, from: emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.someString == emptyString, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(OptionalString.self, from: whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.someString == whitespaceString, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(OptionalString.self, from: nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.someString == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalString.self, from: missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.someString == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalString.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.someString == nil, "Invalid type decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == nullLiteralJSON, "Encoding invalid type produced bad JSON")
                if let decoded = try? decoder.decode(OptionalString.self, from: encoded) {
                    XCTAssert(decoded.someString == nil, "Encoded invalid type decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid type")
                }
            } else {
                XCTFail("Failed to encode invalid type")
            }
        } else {
            XCTFail("Failed to decode invalid type")
        }
    }
    
    // MARK: Optional Null Omitting
    func testOptionalNullOmitting() {
        
    }
    
    // MARK: Optional Strict
    func testOptionalStrict() {
        
    }
    
    // MARK: Optional Strict Null Omitting
    func testOptionalStrictNullOmitting() {
        
    }
    
    // MARK: Required
    func testRequired() {
        
    }
    
    // MARK: Required Strict
    func testRequiredStrict() {
        
    }
}
