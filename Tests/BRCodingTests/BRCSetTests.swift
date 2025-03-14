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
    
    // MARK: Test Data
    private let set: Set<Int> = [1, 3, 5, 7, 11]
    private lazy var setJSONData = (try? encoder.encode(["testValue":set]))!
    
    private let array: [Int] = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    private lazy var arrayJSONData = (try? encoder.encode(["testValue":array]))!
    
    private let invalidTypeJSONData = #"{"testValue":"Cool Beans"}"#.data(using: .utf8)!
    
    // MARK: NonNullable
    private struct SetNonNullable: Codable {
        @BRCSetNonNullable private(set) var testValue: Set<Int>
    }
    
    func testNonNullable() {
        if let setTest = try? decoder.decode(SetNonNullable.self, from: setJSONData) {
            XCTAssert(setTest.testValue == set, "Set decoded incorrectly")
            
            if let encoded = try? encoder.encode(setTest) {
                if let decoded = try? decoder.decode(SetNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == set, "Encoded set decoded incorrectly")
                } else {
                    XCTFail("Encoded set failed to decode")
                }
            } else {
                XCTFail("Set failed to encode")
            }
        } else {
            XCTFail("Set failed to decode")
        }
        
        if let arrayTest = try? decoder.decode(SetNonNullable.self, from: arrayJSONData) {
            XCTAssert(arrayTest.testValue == Set(array), "Array decoded incorrectly")
        } else {
            XCTFail("Array failed to decode")
        }
        
        if let invalidTypeTest = try? decoder.decode(SetNonNullable.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == [], "Invalid Type decoded incorrectly")
        } else {
            XCTFail("Invalid Type failed to decode")
        }
        
        if let nullLiteralTest = try? decoder.decode(SetNonNullable.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == [], "Null Literal decoded incorrectly")
        } else {
            XCTFail("Null Literal failed to decode")
        }
        
        if let missingFieldTest = try? decoder.decode(SetNonNullable.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == [], "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
}
