//
//  BRCArrayNonNullableFailureDroppingTests.swift
//
//
//  Created by Ben Roaman on 3/23/25.
//

import XCTest
@testable import BRCoding

final class BRCArrayNonNullableFailureDroppingTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCArrayNonNullableFailureDropping private(set) var testValue: [Int]
    }
    
    // MARK: Decoding Tests
    func testDecodingCompletelyValidArray() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.completelyDecodableArrayJSONData) {
            XCTAssert(test.testValue == ArrayTestData.completelyDecodableArray, "Completely decodable array decoded incorrectly")
        } else {
            XCTFail("Completely decodable array failed to decode")
        }
    }
    
    func testDecodingPartiallyValidArrayRemovesInvalidElements() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.partiallyDecodableArrayJSONData) {
            XCTAssert(test.testValue == ArrayTestData.completelyDecodableArray, "Partially decodable array decoded incorrectly")
        } else {
            XCTFail("Partially decodable array failed to decode")
        }
    }
    
    func testCompletelyInvalidArrayDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.completelyUndecodableArrayJSONData) {
            XCTAssert(test.testValue.isEmpty, "Completely undecodable array decoded incorrectly")
        } else {
            XCTFail("Completely undecodable array failed to decode")
        }
    }
    
    func testNullLiteralDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(test.testValue.isEmpty, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: ArrayTestData.invalidTypeJSONData) {
            XCTAssert(test.testValue.isEmpty, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    func testMissingFieldDecodesToEmptyArray() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(test.testValue.isEmpty, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testEncodingValidArrayDecodesCorrectly() {
        let test = TestCodable(testValue: ArrayTestData.completelyDecodableArray)
                
        if let encoded = try? encoder.encode(test) {
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == ArrayTestData.completelyDecodableArray, "Completey decodable array encoded then decoded incorrectly")
            } else {
                XCTFail("Completely decodable array encoded then failed to decode")
            }
        } else {
            XCTFail("Completely decodable array failed to encode")
        }
    }
}

