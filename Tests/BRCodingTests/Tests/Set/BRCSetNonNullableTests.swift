//
//  BRCSetNonNullableTests.swift
//
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCSetNonNullableTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCSetNonNullable private(set) var testValue: Set<Int>
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
}
