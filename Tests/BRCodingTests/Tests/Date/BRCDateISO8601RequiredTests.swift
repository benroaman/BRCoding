//
//  BRCDateISO8601RequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCDateISO8601RequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCDateISO8601Required private(set) var testValue: Date
    }
    
    // MARK: Decoding Tests
    func testValidDateDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: DateTestData.validDateJSONData) {
            XCTAssert(test.testValue.timeIntervalSince1970 == DateTestData.validDateLocalized.timeIntervalSince1970, "Valid date epoch does not match")
            XCTAssert(test.testValue.ISO8601Format() == DateTestData.validDateLocalized.ISO8601Format(), "Valid date ISO8601 does not match")
        } else {
            XCTFail("Valid date failed to decode")
        }
    }
    
    func testNullLiteralDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Null literal decoded, should have failed")
        }
    }
    
    func testMissingFieldDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Missing field decoded, should have failed")
        }
    }
    
    func testInvalidDateDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: DateTestData.invalidDateJSONData) {
            XCTFail("Invalid date decoded, should have failed")
        }
    }
    
    func testInvalidTypeDoesNotDecode() {
        if let _ = try? decoder.decode(TestCodable.self, from: DateTestData.invalidTypeJSONData) {
            XCTFail("Invalid type decoded, should have failed")
        }
    }
    
    // MARK: Encoding Tests
    func testValidDateEncodesCorrectly() {
        let test = (try? decoder.decode(TestCodable.self, from: DateTestData.validDateJSONData))!
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.validDateJSON, "Valid date encoding produced incorrect JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue.timeIntervalSince1970 == DateTestData.validDateLocalized.timeIntervalSince1970, "Valid date encoded then decoded with epoch mismatch")
                XCTAssert(decoded.testValue.ISO8601Format() == DateTestData.validDateLocalized.ISO8601Format(), "Valid date encoded then decoded with ISO8601 mismatch")
            } else {
                XCTFail("Valid date encoded then failed to decode")
            }
        } else {
            XCTFail("Valid date failed to encode")
        }
    }
}
