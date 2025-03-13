//
//  File.swift
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
    
    // MARK: Test BRCSelfValidatingEntity Implementation
    private struct Entity: BRCSelfValidatingEntity, Equatable {
        let id: Int
        let testInt: Int?
        let testString: String?
        let kind: Kind
        
        enum Kind: String, Codable {
            case int, string
        }
        
        var isValid: Bool {
            switch kind {
            case .int: return testInt != nil
            case .string: return testString != nil
            }
        }
        
        static func ==(lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id && lhs.testInt == rhs.testInt && lhs.testString == rhs.testString && lhs.kind == rhs.kind }
    }
    
    // MARK: Test Data
    private let completelyValidArray: [Entity] = [Entity(id: 1, testInt: 123, testString: nil, kind: .int),
                                                  Entity(id: 2, testInt: nil, testString: "Test", kind: .string)]
    private lazy var completelyValidArrayJSONData = (try? encoder.encode(["testArray": completelyValidArray]))!
    private lazy var completelyValidArrayJSON = String(data: completelyValidArrayJSONData, encoding: .utf8)!
    
    private let partiallyValidArray: [Entity] = [Entity(id: 1, testInt: 123, testString: nil, kind: .int),
                                                 Entity(id: 2, testInt: nil, testString: nil, kind: .string),
                                                 Entity(id: 3, testInt: nil, testString: "Test", kind: .string)] // valid ids are 1, 3
    private lazy var partiallyValidArrayJSONData = (try? encoder.encode(["testArray": partiallyValidArray]))!
    private lazy var partiallyValidArrayJSON = String(data: partiallyValidArrayJSONData, encoding: .utf8)!
    
    private let completelyInvalidArray: [Entity] = [Entity(id: 1, testInt: nil, testString: nil, kind: .int),
                                                    Entity(id: 2, testInt: nil, testString: nil, kind: .string),
                                                    Entity(id: 3, testInt: nil, testString: nil, kind: .string)]
    private lazy var completelyInvalidArrayJSONData = (try? encoder.encode(["testArray": completelyInvalidArray]))!
    private lazy var completelyInvalidArrayJSON = String(data: completelyInvalidArrayJSONData, encoding: .utf8)!
    
    private let emptyArray: [Entity] = []
    private lazy var emptyArrayJSONData = (try? encoder.encode(["testArray": emptyArray]))!
    private lazy var emptyArrayJSON = String(data: emptyArrayJSONData, encoding: .utf8)!
    
    private let nullLiteralJSONData = #"{"testArray": null}"#.data(using: .utf8)!
    private let invalidTypeJSONData = #"{"testArray": 12345}"#.data(using: .utf8)!
    private let missingFieldJSON = #"{}"#
    private lazy var missingFieldJSONData = missingFieldJSON.data(using: .utf8)!
    
    // MARK: Non Nullable
    private struct ArrayNonNullable: Codable {
        @BRCArrayNonNullable private(set) var testArray: [Entity]
    }
    
    func testNonNullable() {
        if let completelyValidTest = try? decoder.decode(ArrayNonNullable.self, from: completelyValidArrayJSONData) {
            XCTAssert(completelyValidTest.testArray == completelyValidArray, "Completely valid array decoded incorrectly")
            
            if let encoded = try? encoder.encode(completelyValidTest) {
                if let decoded = try? decoder.decode(ArrayNonNullable.self, from: encoded) {
                    XCTAssert(decoded.testArray == completelyValidArray, "Encoded completely valid array decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded completely valid array")
                }
            } else {
                XCTFail("Failed to encode completely valid array")
            }
        } else {
            XCTFail("Completely valid array failed to decode")
        }
        
        if let emptyArrayTest = try? decoder.decode(ArrayNonNullable.self, from: emptyArrayJSONData) {
            XCTAssert(emptyArrayTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let nullLiteralTest = try? decoder.decode(ArrayNonNullable.self, from: nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let invalidTypeTest = try? decoder.decode(ArrayNonNullable.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let missingFieldTest = try? decoder.decode(ArrayNonNullable.self, from: missingFieldJSONData) {
            XCTAssert(missingFieldTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
    }
    
    // MARK: Non Nullable Validated
    private struct ArrayNonNullableValidated: Codable {
        @BRCArrayNonNullableValidated private(set) var testArray: [Entity]
    }
    
    func testNonNullableValidated() {
        if let completelyValidTest = try? decoder.decode(ArrayNonNullableValidated.self, from: completelyValidArrayJSONData) {
            XCTAssert(completelyValidTest.testArray == completelyValidArray, "Completely valid array decoded incorrectly")
            
            if let encoded = try? encoder.encode(completelyValidTest) {
                if let decoded = try? decoder.decode(ArrayNonNullableValidated.self, from: encoded) {
                    XCTAssert(decoded.testArray == completelyValidArray, "Encoded completely valid array decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded completely valid array")
                }
            } else {
                XCTFail("Failed to encode completely valid array")
            }
        } else {
            XCTFail("Completely valid array failed to decode")
        }
        
        if let partiallyValidTest = try? decoder.decode(ArrayNonNullableValidated.self, from: partiallyValidArrayJSONData) {
            XCTAssert(partiallyValidTest.testArray.map({ $0.id }) == [1,3], "Partially valid array decoded incorrectly")
        } else {
            XCTFail("Partially valid array failed to decode")
        }
        
        if let completelyInvalidTest = try? decoder.decode(ArrayNonNullableValidated.self, from: completelyInvalidArrayJSONData) {
            XCTAssert(completelyInvalidTest.testArray == emptyArray, "Completely invalid array decoded incorrectly")
        } else {
            XCTFail("Completely invalid array failed to decode")
        }
        
        if let emptyArrayTest = try? decoder.decode(ArrayNonNullableValidated.self, from: emptyArrayJSONData) {
            XCTAssert(emptyArrayTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let nullLiteralTest = try? decoder.decode(ArrayNonNullableValidated.self, from: nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let invalidTypeTest = try? decoder.decode(ArrayNonNullableValidated.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
        
        if let missingFieldTest = try? decoder.decode(ArrayNonNullableValidated.self, from: missingFieldJSONData) {
            XCTAssert(missingFieldTest.testArray == emptyArray, "Empty array decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty array")
        }
    }
}
