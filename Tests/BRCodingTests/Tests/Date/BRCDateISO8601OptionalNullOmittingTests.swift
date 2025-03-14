//
//  BRCDateISO8601OptionalNullOmittingTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCDateISO8601OptionalNullOmittingTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCDateISO8601OptionalNullOmitting private(set) var testValue: Date?
        init(testValue: Date?) { self.testValue = testValue }
    }
    
    // MARK: Decoding Tests
    func testValidDateDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: DateTestData.validDateJSONData) {
            XCTAssert(test.testValue?.timeIntervalSince1970 == DateTestData.validDateLocalized.timeIntervalSince1970, "Valid date epoch does not match")
            XCTAssert(test.testValue?.ISO8601Format() == DateTestData.validDateLocalized.ISO8601Format(), "Valid date ISO8601 does not match")
        } else {
            XCTFail("Valid date failed to decode")
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
    
    func testInvalidDateDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: DateTestData.invalidDateJSONData) {
            XCTAssert(test.testValue == nil, "Invalid date decoded incorrectly")
        } else {
            XCTFail("Invalid date failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: DateTestData.invalidTypeJSONData) {
            XCTAssert(test.testValue == nil, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
    }
    
    // Encoding Tests
    func testValidDateEncodesCorrectly() {
        let test = (try? decoder.decode(TestCodable.self, from: DateTestData.validDateJSONData))!
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.validDateJSON, "Valid date encoding produced incorrect JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue?.timeIntervalSince1970 == DateTestData.validDateLocalized.timeIntervalSince1970, "Valid date encoded then decoded with epoch mismatch")
                XCTAssert(decoded.testValue?.ISO8601Format() == DateTestData.validDateLocalized.ISO8601Format(), "Valid date encoded then decoded with ISO8601 mismatch")
            } else {
                XCTFail("Valid date encoded then failed to decode")
            }
        } else {
            XCTFail("Valid date failed to encode")
        }
    }
    
    func testNilDoesNotEncode() {
        let test = TestCodable(testValue: nil)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Valid date encoding produced incorrect JSON")
        } else {
            XCTFail("Valid date failed to encode")
        }
    }
}
