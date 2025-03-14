//
//  BRCBoolOptionalTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCBoolOptionalTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct TestCodable: Codable {
        @BRCBoolOptional private(set) var testValue: Bool?
        
        init(testValue: Bool?) {
            self.testValue = testValue
        }
    }
    
    func testDecodeOptionalWithValuePresent() throws {
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
    
    func testDecodeOptionalWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(TestCodable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing Field decoded incorrectly")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeOptionalWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testValue == nil, "String Value decoded incorrectly")
        } else {
            XCTFail("Failed to decode String Value")
        }
                
        if let invalidIntTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testValue == nil, "Invalid Int decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(TestCodable.self, from: BoolTestData.invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Double Value decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Double Value")
        }
    }
    
    func testEncodeOptional() {
        // True
        let testObjectTrue = TestCodable(testValue: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTFail("Failed to encode Optional Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(TestCodable.self, from: encodedTrue) else { return XCTFail("Failed to decode encoded Optional Bool Object") }
        XCTAssert(decodedTrue.testValue == true, "Optional Bool Object Decoded Incorrectly")
        
        // Nil
        let testObjectNil = TestCodable(testValue: nil)
        
        guard let encodedNil = try? encoder.encode(testObjectNil) else { return XCTFail("Failed to encode Optional Bool Object") }
        XCTAssert((String(data: encodedNil, encoding: .utf8) ?? "invalid json") == #"{"testValue":null}"#, "Encoding produced bad JSON String")
        
        guard let decodedNil = try? decoder.decode(TestCodable.self, from: encodedNil) else { return XCTFail("Failed to decode encoded Optional Bool Object") }
        XCTAssert(decodedNil.testValue == nil, "Optional Bool Object Decoded Incorrectly")
    }
}
