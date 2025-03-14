//
//  BRCStringyValueOptionalTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringyValueOptionalTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Optional
    private struct OptionalValue: Codable {
        @BRCStringyValueOptional private(set) var testValue: Int?
    }
    
    func testOptional() {
        if let intTest = try? decoder.decode(OptionalValue.self, from: StringyValueTestData.intJSONData) {
            XCTAssert(intTest.testValue == StringyValueTestData.testInt, "Int decoded incorrectly")
            
            if let encoded = try? encoder.encode(intTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == StringyValueTestData.intJSON, "Encoding int produced bad JSON")
                
                if let decoded = try? decoder.decode(OptionalValue.self, from: encoded) {
                    XCTAssert(decoded.testValue == StringyValueTestData.testInt, "Encoded int decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded int")
                }
            } else {
                XCTFail("Failed to encode int")
            }
        } else {
            XCTFail("Int failed to decode")
        }
        
        if let nullLiteralTest = try? decoder.decode(OptionalValue.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let invalidTypeTest = try? decoder.decode(OptionalValue.self, from: StringyValueTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == nil, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Failed to decode invalid type")
        }
        
        if let missingFieldTest = try? decoder.decode(OptionalValue.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == nil, "Missing field decoded incorrectly")
            
            if let encoded = try? encoder.encode(missingFieldTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Encoding int produced bad JSON")
            } else {
                XCTFail("Failed to encode missing field")
            }
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
}
