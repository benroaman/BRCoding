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
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCStringOptionalStrict private(set) var testValue: String?
    }
    
    // MARK: Decoding Tests
    func testValidStringDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.validStringJSONData) {
            XCTAssert(test.testValue == StringTestData.validString, "Valid string decoded incorrectly")
        } else {
            XCTFail("Valid string failed to decode")
        }
    }
    
    func testEmptyStringDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.emptyStringJSONData) {
            XCTAssert(test.testValue == nil, "Empty string decoded incorrectly")
        } else {
            XCTFail("Empty string failed to decode")
        }
    }
    
    func testWhitespaceStringDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.whitespaceStringJSONData) {
            XCTAssert(test.testValue == nil, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Whitespace string failed to decode")
        }
    }
    
    func testNullLiteralDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(test.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testMissingFieldDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(test.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.invalidTypeJSONData) {
            XCTAssert(test.testValue == nil, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testValidStringEncodesCorrectly() {
        let test = TestCodable(testValue: StringTestData.validString)
        
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
    
    func testNilEncodesToNull() {
        let test = TestCodable(testValue: nil)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Encoding nil produced incorrect JSON")
        } else {
            XCTFail("Nil failed to encode")
        }
    }
}
