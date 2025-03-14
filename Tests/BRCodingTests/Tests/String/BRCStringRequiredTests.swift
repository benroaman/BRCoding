//
//  BRCStringRequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringRequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Required
    private struct StringRequired: Codable {
        @BRCStringRequired private(set) var testValue: String
    }
    
    func testRequired() {
        if let validStringTestObject = try? decoder.decode(StringRequired.self, from: StringTestData.validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == StringTestData.validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == StringTestData.validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringRequired.self, from: encoded) {
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
        
        if let emptyStringTestObject = try? decoder.decode(StringRequired.self, from: StringTestData.emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == StringTestData.emptyString, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringRequired.self, from: StringTestData.whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == StringTestData.whitespaceString, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let _ = try? decoder.decode(StringRequired.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Decoded null literal, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequired.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Decoded missing field, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequired.self, from: StringTestData.invalidTypeJSONData) {
            XCTFail("Decoded invalid type, should have failed")
        }
    }
}
