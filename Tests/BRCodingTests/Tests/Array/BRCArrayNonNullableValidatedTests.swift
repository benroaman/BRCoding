//
//  BRCArrayNonNullableValidatedTests.swift
//
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCArrayNonNullableValidatedTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCArrayNonNullableValidated private(set) var testValue: [ArrayTestData.Entity]
    }
    
    // MARK: Decoding Tests
    func testDecodingCompletelyValidArray() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.completelyValidArrayJSONData) {
            XCTAssert(test.testValue == ArrayTestData.completelyValidArray, "Completely valid array decoded incorrectly")
        } else {
            XCTFail("Completely valid array failed to decode")
        }
    }
    
    func testDecodingPartiallyValidArrayRemovesInvalidElements() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.partiallyValidArrayJSONData) {
            XCTAssert(test.testValue == ArrayTestData.completelyValidArray, "Partially valid array decoded incorrectly")
        } else {
            XCTFail("Partially valid array failed to decode")
        }
    }
    
    func testCompletelyInvalidArrayDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.completelyInvalidArrayJSONData) {
            XCTAssert(test.testValue == ArrayTestData.emptyArray, "Completely invalid array decoded incorrectly")
        } else {
            XCTFail("Completely invalid array failed to decode")
        }
    }
    
    func testNullLiteralDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(test.testValue == ArrayTestData.emptyArray, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.invalidTypeJSONData) {
            XCTAssert(test.testValue == ArrayTestData.emptyArray, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    func testMissingFieldDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(test.testValue == ArrayTestData.emptyArray, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testEncodingValidArrayDecodesCorrectly() {
        let test = TestCodable(testValue: ArrayTestData.completelyValidArray)
                
        if let encoded = try? encoder.encode(test) {
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == ArrayTestData.completelyValidArray, "Completey valid array encoded then decoded incorrectly")
            } else {
                XCTFail("Completely valid array encoded then failed to decode")
            }
        } else {
            XCTFail("Completely valid array failed to encode")
        }
    }
}
