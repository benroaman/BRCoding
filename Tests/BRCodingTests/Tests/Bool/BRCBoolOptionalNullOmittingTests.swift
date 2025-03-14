//
//  BRCBoolOptionalNullOmittingTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCBoolOptionalNullOmittingTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCBoolOptionalNullOmitting private(set) var testValue: Bool?
        init(testValue: Bool?) { self.testValue = testValue }
    }
    
    // MARK: Decoding Tests
    func testTrueLiteralDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueLiteralJSONData) {
            XCTAssert(test.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("True literal failed to decode")
        }
    }
    
    func testTrueIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueIntJSONData) {
            XCTAssert(test.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("True numerical failed to decode")
        }
    }
    
    func testTrueStringyBoolDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyBoolJSONData) {
            XCTAssert(test.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("True stringy bool failed to decode")
        }
    }
    
    func testTrueStringyIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyIntJSONData) {
            XCTAssert(test.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("True stringy int failed to decode")
        }
    }
    
    func testFalseLiteralDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseLiteralJSONData) {
            XCTAssert(test.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("False literal failed to decode")
        }
    }
    
    func testFalseIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseIntJSONData) {
            XCTAssert(test.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("False int failed to decode")
        }
    }
    
    func testFalseStringyBoolDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyBoolJSONData) {
            XCTAssert(test.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("False stringy bool failed to decode")
        }
    }
    
    func testFalseStringyIntDecodesCorrectly() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyIntJSONData) {
            XCTAssert(test.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("False stringy int failed to decode")
        }
    }
    
    func testNullLiteralDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssertNil(test.testValue, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
    }
    
    func testMissingFieldDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssertNil(test.testValue, "Missing Field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    func testInvalidStringDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidStringJSONData) {
            XCTAssertNil(test.testValue, "String Value decoded incorrectly")
        } else {
            XCTFail("Invalid string failed to decode")
        }
    }
    
    func testInvalidIntDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidIntJSONData) {
            XCTAssertNil(test.testValue, "Invalid Int decoded incorrectly")
        } else {
            XCTAssert(false, "Invalid int failed to decode")
        }
    }
    
    func testInvalidTypeDecodesToNil() {
        if let test = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidTypeJSONData) {
            XCTAssertNil(test.testValue, "Double Value decoded incorrectly")
        } else {
            XCTAssert(false, "Invalid type failed to decode")
        }
    }
    
    // MARK: Encoding Tests
    func testTrueEncodesCorrectly() {
        let test = TestCodable(testValue: true)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == BoolTestData.trueLiteralJSON, "True encoding produced incorrect JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == true, "True encoded then decoded incorrectly")
            } else {
                XCTFail("True encoded then failed to decode")
            }
        } else {
            XCTFail("True failed to encode")
        }
    }
    
    func testFalseEncodesCorrectly() {
        let test = TestCodable(testValue: false)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == BoolTestData.falseLiteralJSON, "False encoding produced incorrect JSON")
            
            if let decoded = try? decoder.decode(TestCodable.self, from: encoded) {
                XCTAssert(decoded.testValue == false, "False encoded then decoded incorrectly")
            } else {
                XCTFail("False encoded then failed to decode")
            }
        } else {
            XCTFail("False failed to encode")
        }
    }
    
    func testNilEncodesToNullLiteral() {
        let test = TestCodable(testValue: nil)
        
        if let encoded = try? encoder.encode(test) {
            XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Nil encoding produced incorrect JSON")
        } else {
            XCTFail("Nil failed to encode")
        }
    }
}
