//
//  BRCSetNonNullableEmptyOmittingTests.swift
//
//
//  Created by Ben Roaman on 3/15/25.
//

import XCTest
@testable import BRCoding

final class BRCSetNonNullableEmptyOmittingTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCSetNonNullableEmptyOmitting private(set) var testValue: Set<Int>
    }
    
    // MARK: Decoding Tests
    func testValidSetDecodesCorrectly() {
        if let setTest = try? decoder.decode(TestCodable.self, from: SetTestData.setJSONData) {
            XCTAssert(setTest.testValue == SetTestData.set, "Set decoded incorrectly")
        } else {
            XCTFail("Set failed to decode")
        }
    }
    
    func testDecodingArrayWithRedundanciesProducesCorrectSet() {
        if let test = try? decoder.decode(TestCodable.self, from: SetTestData.arrayJSONData) {
            XCTAssert(test.testValue == Set(SetTestData.array), "Array decoded incorrectly")
        } else {
            XCTFail("Array failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToEmptySet() {
        if let test = try? decoder.decode(TestCodable.self, from: SetTestData.invalidTypeJSONData) {
            XCTAssert(test.testValue.isEmpty, "Invalid Type decoded incorrectly")
        } else {
            XCTFail("Invalid Type failed to decode")
        }
    }
    
    func testNullLiteralDecodesToEmptySet() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(test.testValue.isEmpty, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Null Literal failed to decode")
        }
    }
    
    func testMissingFieldDecodesToEmptySet() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(test.testValue.isEmpty, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testEncodingSet() {
        let test = TestCodable(testValue: SetTestData.set)
        
        if let encoded = try? encoder.encode(test) {
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == SetTestData.set, "Set encoded then decoded incorrectly")
            } else {
                XCTFail("Set encoded then failed to decode")
            }
        } else {
            XCTFail("Set failed to encode")
        }
    }
    
    func testEncodingEmptySet() {
        let test = TestCodable(testValue: [])
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Empty set should be omitted from encoding")
        } else {
            XCTFail("Set failed to encode")
        }
    }
}

