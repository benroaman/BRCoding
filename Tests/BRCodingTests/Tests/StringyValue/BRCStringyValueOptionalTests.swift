//
//  BRCStringyValueOptionalTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringyValueOptionalTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCStringyValueOptional private(set) var testValue: Int?
    }
    
    // MARK: Decoding Tests
    func testIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringyValueTestData.intJSONData) {
            XCTAssert(test.testValue == StringyValueTestData.testInt, "Int decoded incorrectly")
        } else {
            XCTFail("Int failed to decode")
        }
    }
    
    func testStringyIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringyValueTestData.stringyIntJSONData) {
            XCTAssert(test.testValue == StringyValueTestData.testInt, "Stringy int decoded incorrectly")
        } else {
            XCTFail("Stringy int failed to decode")
        }
    }
    
    func testNullLiteralDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssertNil(test.testValue, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: StringyValueTestData.invalidTypeJSONData) {
            XCTAssertNil(test.testValue, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    func testMissingFieldDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssertNil(test.testValue, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testIntEncodesCorrectly() {
        let test = TestCodable(testValue: StringyValueTestData.testInt)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == StringyValueTestData.intJSON, "Int encoding produced bad JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == StringyValueTestData.testInt, "Int encoded then decoded incorrectly")
            } else {
                XCTFail("Int encoded then failed to decode")
            }
        } else {
            XCTFail("Int failed to encode")
        }
    }
    
    func testNilDoesNotEncode() {
        let test = TestCodable(testValue: nil)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Encoding int produced bad JSON")
        } else {
            XCTFail("Failed to encode missing field")
        }
    }
}
