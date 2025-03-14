//
//  BRCStringyValueRequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCStringyValueRequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Required
    private struct ReuiredValue: Codable {
        @BRCStringyValueRequired private(set) var testValue: Int
    }
    
    func testRequired() {
        if let intTest = try? decoder.decode(ReuiredValue.self, from: StringyValueTestData.intJSONData) {
            XCTAssert(intTest.testValue == StringyValueTestData.testInt, "Int decoded incorrectly")
            
            if let encoded = try? encoder.encode(intTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == StringyValueTestData.intJSON, "Encoding int produced bad JSON")
                
                if let decoded = try? decoder.decode(ReuiredValue.self, from: encoded) {
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
        
        if let _ = try? decoder.decode(ReuiredValue.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Null literal decoded, should have failed")
        }
        
        if let _ = try? decoder.decode(ReuiredValue.self, from: StringyValueTestData.invalidTypeJSONData) {
            XCTFail("Invalid type decoded, should have failed")
        }
        
        if let _ = try? decoder.decode(ReuiredValue.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Missing field decoded, should have failed")
        }
    }
}
