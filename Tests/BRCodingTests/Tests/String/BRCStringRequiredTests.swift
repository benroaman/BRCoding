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
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCStringRequired private(set) var testValue: String
    }
    
    // MARK: Decoding Tests
    func testValidStringDecodesCorrectly() {
        if let validStringTestObject = try? decoder.decode(TestCodable.self, from: StringTestData.validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == StringTestData.validString, "Valid string decoded incorrectly")
        } else {
            XCTFail("Valid string failed to decode")
        }
    }
    
    func testEmptyStringDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.emptyStringJSONData) {
            XCTAssert(test.testValue == StringTestData.emptyString, "Empty string decoded incorrectly")
        } else {
            XCTFail("Empty string failed to decode")
        }
    }
    
    func testWhitespaceDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.whitespaceStringJSONData) {
            XCTAssert(test.testValue == StringTestData.whitespaceString, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Whitespace string failed to decode")
        }
    }
    
    func testNullLiteralDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Null literal decoded, should have failed")
        }
    }
    
    func testMissingFieldDecodesToNil() {
        if let _ = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Missing field decoded, should have failed")
        } else {
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let _ = try? decoder.decode(TestCodable.self, from: StringTestData.invalidTypeJSONData) {
            XCTFail("Invalid type decoded, should have failed")
        }
    }
    
    // MARK: Encoding Tests
    func testValidStringEncodesCorrectly() {
        let test = (try? decoder.decode(TestCodable.self, from: StringTestData.validStringJSONData))!
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == StringTestData.validStringJSON, "Valid string encoding produced incorrect JSON")
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == StringTestData.validString, "Valid string encoded then decoded incorrectly")
            } else {
                XCTFail("Valid string encoded then failed to decode")
            }
        } else {
            XCTFail("Valid string failed to encode")
        }
    }
}
