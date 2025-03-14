//
//  BRCArrayTests.swift
//
//
//  Created by Ben Roaman on 3/13/25.
//

import XCTest
@testable import BRCoding

final class BRCArrayTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Non Nullable
    private struct ArrayNonNullable: Codable {
        @BRCArrayNonNullable private(set) var testValue: [ArrayTestData.Entity]
    }
    
    func testNonNullable() {
        if let completelyValidTest = try? decoder.decode(ArrayNonNullable.self, from: ArrayTestData.completelyValidArrayJSONData) {
            XCTAssert(completelyValidTest.testValue == ArrayTestData.completelyValidArray, "Completely valid array decoded incorrectly")
            
            if let encoded = try? encoder.encode(completelyValidTest) {
                if let decoded = try? decoder.decode(ArrayNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == ArrayTestData.completelyValidArray, "Encoded completely valid array decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded completely valid array")
                }
            } else {
                XCTFail("Failed to encode completely valid array")
            }
        } else {
            XCTFail("Completely valid array failed to decode")
        }
        
        if let emptyArrayTest = try? decoder.decode(ArrayNonNullable.self, from: ArrayTestData.emptyArrayJSONData) {
            XCTAssert(emptyArrayTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let nullLiteralTest = try? decoder.decode(ArrayNonNullable.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let invalidTypeTest = try? decoder.decode(ArrayNonNullable.self, from: ArrayTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let missingFieldTest = try? decoder.decode(ArrayNonNullable.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
    }
    
    // MARK: Non Nullable Validated
    private struct ArrayNonNullableValidated: Codable {
        @BRCArrayNonNullableValidated private(set) var testValue: [ArrayTestData.Entity]
    }
    
    func testNonNullableValidated() {
        if let completelyValidTest = try? decoder.decode(ArrayNonNullableValidated.self, from: ArrayTestData.completelyValidArrayJSONData) {
            XCTAssert(completelyValidTest.testValue == ArrayTestData.completelyValidArray, "Completely valid array decoded incorrectly")
            
            if let encoded = try? encoder.encode(completelyValidTest) {
                if let decoded = try? decoder.decode(ArrayNonNullableValidated.self, from: encoded) {
                    XCTAssert(decoded.testValue == ArrayTestData.completelyValidArray, "Encoded completely valid array decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded completely valid array")
                }
            } else {
                XCTFail("Failed to encode completely valid array")
            }
        } else {
            XCTFail("Completely valid array failed to decode")
        }
        
        if let partiallyValidTest = try? decoder.decode(ArrayNonNullableValidated.self, from: ArrayTestData.partiallyValidArrayJSONData) {
            XCTAssert(partiallyValidTest.testValue.map({ $0.id }) == [1,3], "Partially valid array decoded incorrectly")
        } else {
            XCTFail("Partially valid array failed to decode")
        }
        
        if let completelyInvalidTest = try? decoder.decode(ArrayNonNullableValidated.self, from: ArrayTestData.completelyInvalidArrayJSONData) {
            XCTAssert(completelyInvalidTest.testValue == ArrayTestData.emptyArray, "Completely invalid array decoded incorrectly")
        } else {
            XCTFail("Completely invalid array failed to decode")
        }
        
        if let emptyArrayTest = try? decoder.decode(ArrayNonNullableValidated.self, from: ArrayTestData.emptyArrayJSONData) {
            XCTAssert(emptyArrayTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let nullLiteralTest = try? decoder.decode(ArrayNonNullableValidated.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let invalidTypeTest = try? decoder.decode(ArrayNonNullableValidated.self, from: ArrayTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let missingFieldTest = try? decoder.decode(ArrayNonNullableValidated.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == ArrayTestData.emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
    }
}
