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
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCStringRequiredStrict private(set) var testValue: String
    }
    
    // MARK: Decoding Tests
    func testValidStringDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringTestData.validStringJSONData) {
            XCTAssert(test.testValue == StringTestData.validString, "Valid string decoded incorrectly")
        } else {
            XCTFail("Valid string failed to decode")
        }
    }
    
    func testEmptyStringDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: StringTestData.emptyStringJSONData), "Empty string decoded, should have failed")
    }
    
    func testWhitespaceStringDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: StringTestData.whitespaceStringJSONData), "Whitespace string decoded, should have failed")
    }
    
    func testNullLiteralDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData), "Null literal decoded, should have failed")
    }
    
    func testMissingFieldDecodesToNil() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData), "Missing field decoded, should have failed")
    }
    
    func testInvalidTypeDecodesToNil() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: StringTestData.invalidTypeJSONData), "Invalid type decoded, should have failed")
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
