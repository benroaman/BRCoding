//
//  BRCStringyValueRequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringyValueRequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCStringyValueRequired private(set) var testValue: Int
    }
    
    // MARK: Decoding Tests
    func testIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringyValueTestData.intJSONData) {
            XCTAssert(test.testValue == StringyValueTestData.testInt, "Int decoded incorrectly")
        } else {
            XCTFail("Int failed to decode")
        }
    }
    
    func testStringyIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: StringyValueTestData.stringyIntJSONData) {
            XCTAssert(test.testValue == StringyValueTestData.testInt, "Stringy int decoded incorrectly")
        } else {
            XCTFail("Stringy int failed to decode")
        }
    }
    
    func testNullLiteralDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData), "Null literal decoded, should have failed")
    }
    
    func testInvalidTypeDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: StringyValueTestData.invalidTypeJSONData), "Invalid type decoded, should have failed")
    }
    
    func testMissingFieldDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData), "Missing field decoded, should have failed")
    }
    
    // MARK: Encoding Tests
    func testIntEncodesCorrectly() {
        let test = (try? decoder.decode(TestCodable.self, from: StringyValueTestData.intJSONData))!
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == StringyValueTestData.intJSON, "Int encoding produced bad JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == StringyValueTestData.testInt, "Int encoded then decoded incorrectly")
            } else {
                XCTFail("Int encoded then failed to decode")
            }
        } else {
            XCTFail("Int failed to encode")
        }
    }
}
