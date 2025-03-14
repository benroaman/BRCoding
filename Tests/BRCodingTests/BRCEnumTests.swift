//
//  BRCEnumTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCEnumTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Types
    private enum TestEnum: String, BRCEnumWithFallback {
        case hello, world, unsupported
        
        static var fallbackCase: Self { .unsupported }
    }
    
    // MARK: Test Data
    private let validCase = TestEnum.world
    private lazy var validCaseJSONData = (try? encoder.encode(["testValue":validCase]))!
    private lazy var validCaseJSON = String(data: validCaseJSONData, encoding: .utf8)!
    
    private let invalidCaseJSONJData = #"{"testValue":"allmight"}"#.data(using: .utf8)!
    private let invalidTypeJSONData = #"{"testValue":12345}"#.data(using: .utf8)!
    
    private let fallbackJSON = #"{"testValue":"\#(TestEnum.fallbackCase.rawValue)"}"#
    
    // MARK: Non Nullable
    private struct EnumNonNullable: Codable {
        @BRCEnumNonNullable private(set) var testValue: TestEnum
    }

    func testNonNullable() {
        if let validCaseTest = try? decoder.decode(EnumNonNullable.self, from: validCaseJSONData) {
            XCTAssert(validCaseTest.testValue == validCase, "Valid case decoded incorrectly")
            
            if let encoded = try? encoder.encode(validCaseTest) {
                XCTAssert(String(data: encoded, encoding: .utf8) == validCaseJSON, "Valid case encoding produced bad JSON")
                
                if let decoded = try? decoder.decode(EnumNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == validCase, "Valid case encoded then decoded incorrectly")
                } else {
                    XCTFail("Valid case encoded failed to decode")
                }
            } else {
                XCTFail("Valid case failed to encode")
            }
        } else {
            XCTFail("Valid case failed to decode")
        }
        
        if let invalidCaseTest = try? decoder.decode(EnumNonNullable.self, from: invalidCaseJSONJData) {
            XCTAssert(invalidCaseTest.testValue == TestEnum.fallbackCase, "Invalid case decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidCaseTest) {
                XCTAssert(String(data: encoded, encoding: .utf8) == fallbackJSON, "Invalid case encoding produced bad JSON")
                
                if let decoded = try? decoder.decode(EnumNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testValue == TestEnum.fallbackCase, "Invalid case encoded then decoded incorrectly")
                } else {
                    XCTFail("Invalid case encoded failed to decode")
                }
            } else {
                XCTFail("Invalid case failed to encode")
            }
        } else {
            XCTFail("Invalid case failed to decode")
        }
        
        if let invalidTypeTest = try? decoder.decode(EnumNonNullable.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == TestEnum.fallbackCase, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
        
        if let nullLiteralTest = try? decoder.decode(EnumNonNullable.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == TestEnum.fallbackCase, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
        
        if let missingFieldTest = try? decoder.decode(EnumNonNullable.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == TestEnum.fallbackCase, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
}
