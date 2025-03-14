//
//  BRCStringRequiredStrictTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringRequiredStrictTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Required Strict
    private struct StringRequiredStrict: Codable {
        @BRCStringRequiredStrict private(set) var testValue: String
    }
    
    func testRequiredStrict() {
        if let validStringTestObject = try? decoder.decode(StringRequiredStrict.self, from: StringTestData.validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == StringTestData.validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == StringTestData.validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringRequiredStrict.self, from: encoded) {
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
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: StringTestData.emptyStringJSONData) {
            XCTFail("Decoded empty string, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: StringTestData.whitespaceStringJSONData) {
            XCTFail("Decoded whitespace string, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Decoded null literal, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Decoded missing field, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: StringTestData.invalidTypeJSONData) {
            XCTFail("Decoded invalid type, should have failed")
        }
    }
}
