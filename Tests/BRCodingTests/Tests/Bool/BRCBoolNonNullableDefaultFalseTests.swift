//
//  BRCBoolNonNullableDefaultFalseTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCBoolNonNullableDefaultFalseTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCBoolNonNullableDefaultFalse private(set) var testValue: Bool
    }
    
    func testDecodeDefaultFalseWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueLiteralJSONData) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
           
        if let trueNumericalTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueIntJSON) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let trueStringyIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseLiteralJSONData) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                
        if let falseNumericalTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseIntJSON) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeDefaultFalseWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == false, "Failed to apply default value for null literal")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == false, "Failed to apply default value for missing field")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeDefaultFalseWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testValue == false, "Failed to apply default value for invalid string")
        } else {
            XCTFail("Failed to decode Invalid String")
        }
                
        if let invalidIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testValue == false, "Failed to apply default value for invalid int")
        } else {
            XCTFail("Failed to decode Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testValue == false, "Failed to apply default value for invalid type")
        } else {
            XCTFail("Failed to decode Invalid Type")
        }
    }
    
    func testEncodeDefaultFalse() {
        let testObject = TestCodable(testValue: true)
        
        guard let encoded = try? encoder.encode(testObject) else { return XCTAssert(false, "Failed to encode Default False Object") }
        XCTAssert((String(data: encoded, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decoded = try? decoder.decode(TestCodable.self, from: encoded) else { return XCTAssert(false, "Failed to decode encoded Default False Object") }
        XCTAssert(decoded.testValue == true, "Default False Object Decoded Incorrectly")
    }
}
