//
//  BRCURLRequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCURLRequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCURLRequired private(set) var testValue: URL
    }
    
    // MARK: Decoding Tests
    func testValidURLDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: URLTestData.validURLJSONData) {
            XCTAssert(test.testValue.absoluteString == URLTestData.validURLString, "Valid URL decoded incorrectly")
        } else {
            XCTFail("Valid URL failed to decode")
        }
    }
    
    func testInvalidURLDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: URLTestData.invalidURLJSONData) {
            XCTFail("Invalid URL decoded but should have failed")
        }
    }
    
    func testInvalidTypeDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: URLTestData.invalidTypeJSONData) {
            XCTFail("Invalid type decoded but should have failed")
        }
    }
    
    func testNullLiteralDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Null literal decoded but should have failed")
        }
    }
    
    func testMissingFieldDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Missing field decoded but should have failed")
        }
    }
    
    // MARK: Encoding Tests
    func testValidURLEncodesCorrectly() {
        let test = (try? decoder.decode(TestCodable.self, from: URLTestData.validURLJSONData))!
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == URLTestData.validURLJSON, "Valid URL encoding produced bad JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue.absoluteString == URLTestData.validURLString, "Valid URL encoded then decoded incorrectly")
            } else {
                XCTFail("Valid URL encoded then failed to decode")
            }
        } else {
            XCTFail("Valid URL failed to encode")
        }
    }
}
