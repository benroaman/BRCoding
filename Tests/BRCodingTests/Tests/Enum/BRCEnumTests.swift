//
//  BRCEnumTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCEnumTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Non Nullable
    private struct EnumNonNullable: Codable {
        @BRCEnumNonNullable private(set) var testValue: EnumTestData.TestEnum
    }

    func testEnumNonNullableWithValidCase() {
        if let validCaseTest = try? decoder.decode(EnumNonNullable.self, from: EnumTestData.validCaseJSONData) {
            XCTAssert(validCaseTest.testValue == EnumTestData.validCase, "Valid case decoded incorrectly")
            
            if let encoded = try? encoder.encode(validCaseTest) {
                XCTAssert(String(data: encoded, encoding: .utf8) == EnumTestData.validCaseJSON, "Valid case encoding produced bad JSON")
                
                if let decoded = try? decoder.decode(EnumNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == EnumTestData.validCase, "Valid case encoded then decoded incorrectly")
                } else {
                    XCTFail("Valid case encoded failed to decode")
                }
            } else {
                XCTFail("Valid case failed to encode")
            }
        } else {
            XCTFail("Valid case failed to decode")
        }
    }
        
    func testEnumNonNullableWithInvalidCase() {
        if let invalidCaseTest = try? decoder.decode(EnumNonNullable.self, from: EnumTestData.invalidCaseJSONJData) {
            XCTAssert(invalidCaseTest.testValue == EnumTestData.TestEnum.fallbackCase, "Invalid case decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidCaseTest) {
                XCTAssert(String(data: encoded, encoding: .utf8) == EnumTestData.fallbackJSON, "Invalid case encoding produced bad JSON")
                
                if let decoded = try? decoder.decode(EnumNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == EnumTestData.TestEnum.fallbackCase, "Invalid case encoded then decoded incorrectly")
                } else {
                    XCTFail("Invalid case encoded failed to decode")
                }
            } else {
                XCTFail("Invalid case failed to encode")
            }
        } else {
            XCTFail("Invalid case failed to decode")
        }
    }
    
    func testEnumNonNullableWithInvalidType() {
        if let invalidTypeTest = try? decoder.decode(EnumNonNullable.self, from: EnumTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == EnumTestData.TestEnum.fallbackCase, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    func testEnumNonNullableWithNullLiteral() {
        if let nullLiteralTest = try? decoder.decode(EnumNonNullable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == EnumTestData.TestEnum.fallbackCase, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testEnumNonNullableWithMissingField() {
        if let missingFieldTest = try? decoder.decode(EnumNonNullable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == EnumTestData.TestEnum.fallbackCase, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
}
