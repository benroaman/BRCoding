//
//  BRCEnumNonNullableTests.swift
//
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCEnumNonNullableTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCEnumNonNullable private(set) var testValue: EnumTestData.TestEnum
    }

    // MARK: Decoding Tests
    func testValidCaseDecodesCorrectly() {
        if let validCaseTest = try? decoder.decode(TestCodable.self, from: EnumTestData.validCaseJSONData) {
            XCTAssert(validCaseTest.testValue == EnumTestData.validCase, "Valid case decoded incorrectly")
        } else {
            XCTFail("Valid case failed to decode")
        }
    }
    
    func testInvalidCaseDecodesToFallbackCase() {
        if let invalidCaseTest = try? decoder.decode(TestCodable.self, from: EnumTestData.invalidCaseJSONJData) {
            XCTAssert(invalidCaseTest.testValue == EnumTestData.TestEnum.fallbackCase, "Invalid case decoded incorrectly")
        } else {
            XCTFail("Invalid case failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToFallbackCase() {
        if let invalidTypeTest = try? decoder.decode(TestCodable.self, from: EnumTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == EnumTestData.TestEnum.fallbackCase, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    func testNullLiteralDecodesToFallbackCase() {
        if let nullLiteralTest = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == EnumTestData.TestEnum.fallbackCase, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testMissingFieldDecodesToFallbackCase() {
        if let missingFieldTest = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == EnumTestData.TestEnum.fallbackCase, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testValidCaseEncodesCorrectly() {
        let test = TestCodable(testValue: EnumTestData.validCase)
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8) == EnumTestData.validCaseJSON, "Valid case encoding produced bad JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == EnumTestData.validCase, "Valid case encoded then decoded incorrectly")
            } else {
                XCTFail("Valid case encoded then failed to decode")
            }
        } else {
            XCTFail("Valid case failed to encode")
        }
    }
}
