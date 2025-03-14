//
//  BRCStringOptionalStrictTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringOptionalStrictTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Optional Strict
    private struct StringOptionalStrict: Codable {
        @BRCStringOptionalStrict private(set) var testValue: String?
    }
    
    func testOptionalStrict() {
        if let validStringTestObject = try? decoder.decode(StringOptionalStrict.self, from: StringTestData.validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == StringTestData.validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == StringTestData.validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalStrict.self, from: encoded) {
                    XCTAssert(decoded.testValue == StringTestData.validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(StringOptionalStrict.self, from: StringTestData.emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == nil, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringOptionalStrict.self, from: StringTestData.whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == nil, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(StringOptionalStrict.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(StringOptionalStrict.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(StringOptionalStrict.self, from: StringTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Encoding invalid type produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalStrict.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid type decoded incorrectly")
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
}
