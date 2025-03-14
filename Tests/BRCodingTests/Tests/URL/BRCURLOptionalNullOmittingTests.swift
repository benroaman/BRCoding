//
//  BRCURLOptionalNullOmittingTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCURLOptionalNullOmittingTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCURLOptionalNullOmitting private(set) var testValue: URL?
    }
    
    // MARK: Decoding Tests
    func testValidURLDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: URLTestData.validURLJSONData) {
            XCTAssert(test.testValue?.absoluteString == URLTestData.validURLString, "Valid URL decoded incorrectly")
        } else {
            XCTFail("Valid URL failed to decode")
        }
    }
    
    func testInvalidURLDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: URLTestData.invalidURLJSONData) {
            XCTAssert(test.testValue == nil, "Invalid URL decoded incorrectly")
        } else {
            XCTFail("Invalid URL failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: URLTestData.invalidTypeJSONData) {
            XCTAssert(test.testValue == nil, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
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
    
    // MARK: Encoding Tests
    func testValidURLEncodesCorrectly() {
        let test = TestCodable(testValue: URL(string: URLTestData.validURLString)!)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == URLTestData.validURLJSON, "Valid URL encoding produced bad JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue?.absoluteString == URLTestData.validURLString, "Valid URL encoded then decoded incorrectly")
            } else {
                XCTFail("Valid URL encoded then failed to decode")
            }
        } else {
            XCTFail("Valid URL failed to encode")
        }
    }
    
    func testNilDoesNotEncode() {
        let test = TestCodable(testValue: nil)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Encoding nil produced bad JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == nil, "Nil encoded then decoded incorrectly")
            } else {
                XCTFail("Nil encoded then failed to decode")
            }
        } else {
            XCTFail("Nil failed to encode")
        }
    }
}
