//
//  BRCSetTests.swift
//
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCSetTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: NonNullable
    private struct SetNonNullable: Codable {
        @BRCSetNonNullable private(set) var testValue: Set<Int>
    }
    
    func testNonNullable() {
        if let setTest = try? decoder.decode(SetNonNullable.self, from: SetTestData.setJSONData) {
            XCTAssert(setTest.testValue == SetTestData.set, "Set decoded incorrectly")
            
            if let encoded = try? encoder.encode(setTest) {
                if let decoded = try? decoder.decode(SetNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == SetTestData.set, "Encoded set decoded incorrectly")
                } else {
                    XCTFail("Encoded set failed to decode")
                }
            } else {
                XCTFail("Set failed to encode")
            }
        } else {
            XCTFail("Set failed to decode")
        }
        
        if let arrayTest = try? decoder.decode(SetNonNullable.self, from: SetTestData.arrayJSONData) {
            XCTAssert(arrayTest.testValue == Set(SetTestData.array), "Array decoded incorrectly")
        } else {
            XCTFail("Array failed to decode")
        }
        
        if let invalidTypeTest = try? decoder.decode(SetNonNullable.self, from: SetTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == [], "Invalid Type decoded incorrectly")
        } else {
            XCTFail("Invalid Type failed to decode")
        }
        
        if let nullLiteralTest = try? decoder.decode(SetNonNullable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == [], "Null Literal decoded incorrectly")
        } else {
            XCTFail("Null Literal failed to decode")
        }
        
        if let missingFieldTest = try? decoder.decode(SetNonNullable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == [], "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
}
