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
    
    func testDecodeRequiredWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                        
        if let trueNumericalTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.trueNumericalJSON) {
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
                
        if let falseLiteralTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                        
        if let falseNumericalTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.falseNumericalJSON) {
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
    
    func testDecodeRequiredWithValueAbsent() {
        // Null Literal
        let nullLiteralTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData)
        XCTAssert(nullLiteralTestObject == nil, "Null Literal should cause decode failure")
        
        // Missing Field
        let missingFieldTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData)
        XCTAssert(missingFieldTestObject == nil, "Missing Field should cause decode failure")
    }
    
    func testDecodeRequiredWithInvalidValue() {
        // Invalid String
        let invalidStringTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidStringJSON)
        XCTAssert(invalidStringTestObject == nil, "Invalid String should cause decode failure")
        
        // Invalid Int
        let invalidIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidIntJSON)
        XCTAssert(invalidIntTestObject == nil, "Invalid Int should cause decode failure")
        
        // Invalid Type
        let invalidTypeTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidTypeJSON)
        XCTAssert(invalidTypeTestObject == nil, "Non-Int, Non-String, Non-Bool value should cause decode failure")
    }
    
    func testEncodeRequired() {
        // True
        let testObjectTrue = TestCodable(testValue: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTAssert(false, "Failed to encode Required Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(TestCodable.self, from: encodedTrue) else { return XCTAssert(false, "Failed to decode encoded Required Bool Object") }
        XCTAssert(decodedTrue.testValue == true, "Required Bool Object Decoded Incorrectly")
        
        // False
        let testObjectFalse = TestCodable(testValue: false)
        
        guard let encodedFalse = try? encoder.encode(testObjectFalse) else { return XCTAssert(false, "Failed to encode Required Bool Object") }
        XCTAssert((String(data: encodedFalse, encoding: .utf8) ?? "invalid json") == #"{"testValue":false}"#, "Encoding produced bad JSON String")
        
        guard let decodedFalse = try? decoder.decode(TestCodable.self, from: encodedFalse) else { return XCTAssert(false, "Failed to decode encoded Required Bool Object") }
        XCTAssert(decodedFalse.testValue == false, "Required Bool Object Decoded Incorrectly")
    }
}
