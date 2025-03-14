//
//  BRCBoolNonNullableDefaultTrueTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCBoolNonNullableDefaultTrueTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCBoolNonNullableDefaultTrue private(set) var testValue: Bool
    }
    
    func testDecodeDefaultTrueWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueLiteralJSONData) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                
        if let trueNumericalTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueIntJSONData) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyBoolJSONData) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let truStringyIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueStringyIntJSONData) {
            XCTAssert(truStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseLiteralJSONData) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                
        if let falseNumericalTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseIntJSONData) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyBoolJSONData) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseStringyIntJSONData) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeDefaultTrueWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == true, "Failed to apply default value for null literal")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == true, "Failed to apply default value for missing field")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeDefaultTrueWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidStringJSONData) {
            XCTAssert(invalidStringTestObject.testValue == true, "Failed to apply default value for invalid string")
        } else {
            XCTFail("Failed to decode with String Value")
        }
        
        if let invalidIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidIntJSONData) {
            XCTAssert(invalidIntTestObject.testValue == true, "Failed to apply default value for invalid int")
        } else {
            XCTFail("Failed to decode with Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == true, "Failed to apply default value for invalid type")
        } else {
            XCTFail("Failed to decode with Invalid Type")
        }
    }
    
    func testEncodeDefaultTrue() {
        let testObject = TestCodable(testValue: false)
        
        guard let encoded = try? encoder.encode(testObject) else { return XCTFail("Failed to encode DefaultTrue Object") }
        XCTAssert(String(data: encoded, encoding: .utf8) == #"{"testValue":false}"#, "Encoding produced bad JSON String")
        
        guard let decoded = try? decoder.decode(TestCodable.self, from: encoded) else { return XCTFail("Failed to decode encoded Default True Object") }
        XCTAssert(decoded.testValue == false, "Default True Object Decoded Incorrectly")
    }
}
