//
//  BRCBoolRequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCBoolRequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCBoolRequired private(set) var testValue: Bool
    }
    
    // MARK: Decoding Tests
    func testTrueLiteralDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueLiteralJSONData) {
            XCTAssertTrue(test.testValue, "True Literal decoded incorrectly")
        } else {
            XCTFail("True literal failed to decode")
        }
    }
    
    func testTrueIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueIntJSON) {
            XCTAssertTrue(test.testValue, "True Numerical decoded incorrectly")
        } else {
            XCTFail("True numerical failed to decode")
        }
    }
    
    func testTrueStringyBoolDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssertTrue(test.testValue, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("True stringy bool failed to decode")
        }
    }
    
    func testTrueStringyIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssertTrue(test.testValue, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("True stringy int failed to decode")
        }
    }
    
    func testFalseLiteralDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseLiteralJSONData) {
            XCTAssertFalse(test.testValue, "False Literal decoded incorrectly")
        } else {
            XCTFail("False literal failed to decode")
        }
    }
    
    func testFalseIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseIntJSON) {
            XCTAssertFalse(test.testValue, "False Numerical decoded incorrectly")
        } else {
            XCTFail("False int failed to decode")
        }
    }
    
    func testFalseStringyBoolDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssertFalse(test.testValue, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("False stringy bool failed to decode")
        }
    }
    
    func testFalseStringyIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssertFalse(test.testValue, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("False stringy int failed to decode")
        }
    }
    
    func testNullLiteralDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData), "Null literal should cause decode failure")
    }
    
    func testMissingFieldDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData), "Missing field should cause decode failure")
    }
    
    func testInvalidStringDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: BoolTestData.invalidStringJSON), "Invalid string should cause decode failure")
    }
    
    func testInvalidIntDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: BoolTestData.invalidIntJSON), "Invalid int should cause decode failure")
    }
    
    func testInvalidTypeDoesNotDecode() {
        XCTAssertNil(try? decoder.decode(TestCodable.self, from: BoolTestData.invalidTypeJSON), "Invalid type should cause decode failure")
    }
    
    // MARK: Encoding Tests
    func testEncodingTrue() {
        let test = TestCodable(testValue: true)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == BoolTestData.trueLiteralJSON, "True encoding produced incorrect JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssertTrue(decoded.testValue, "True encoded then decoded with epoch mismatch")
            } else {
                XCTFail("True encoded then failed to decode")
            }
        } else {
            XCTFail("True failed to encode")
        }
    }
    
    func testEncodingFalse() {
        let test = TestCodable(testValue: false)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == BoolTestData.falseLiteralJSON, "False encoding produced incorrect JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssertFalse(decoded.testValue, "False encoded then decoded with epoch mismatch")
            } else {
                XCTFail("False encoded then failed to decode")
            }
        } else {
            XCTFail("False failed to encode")
        }
    }
}
