//
//  BRCStringOptionalNullOmittingTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringOptionalNullOmittingTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCStringOptionalNullOmitting private(set) var testValue: String?
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
    
    func testNullLiteralDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssertNil(test.testValue, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testMissingFieldDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssertNil(test.testValue, "Missing field decoded incorrectly")
        } else {
            XCTFail("Mising field failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.invalidTypeJSONData) {
            XCTAssertNil(test.testValue, "Invalid type decoded incorrectly")
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
    
    func testNilDoesNotEncode() {
        let test = TestCodable(testValue: nil)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Encoding nil produced incorrect JSON")
        } else {
            XCTFail("Nil failed to encode")
        }
    }
}
