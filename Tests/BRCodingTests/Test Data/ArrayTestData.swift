//
//  ArrayTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation
import BRCoding

struct ArrayTestData {
    private init() { }
    
    struct Entity: BRCSelfValidatingEntity, Equatable {
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
    static let completelyValidArray: [Entity] = [Entity(id: 1, testInt: 123, testString: nil, kind: .int),
                                                  Entity(id: 2, testInt: nil, testString: "Test", kind: .string)]
    static let completelyValidArrayJSONData = (try? JSONEncoder().encode(["testValue": completelyValidArray]))!
    static let completelyValidArrayJSON = String(data: completelyValidArrayJSONData, encoding: .utf8)!
    
    static let partiallyValidArray: [Entity] = [Entity(id: 1, testInt: 123, testString: nil, kind: .int),
                                                 Entity(id: 2, testInt: nil, testString: nil, kind: .string),
                                                 Entity(id: 3, testInt: nil, testString: "Test", kind: .string)] // valid ids are 1, 3
    static let partiallyValidArrayJSONData = (try? JSONEncoder().encode(["testValue": partiallyValidArray]))!
    static let partiallyValidArrayJSON = String(data: partiallyValidArrayJSONData, encoding: .utf8)!
    
    static let completelyInvalidArray: [Entity] = [Entity(id: 1, testInt: nil, testString: nil, kind: .int),
                                                    Entity(id: 2, testInt: nil, testString: nil, kind: .string),
                                                    Entity(id: 3, testInt: nil, testString: nil, kind: .string)]
    static let completelyInvalidArrayJSONData = (try? JSONEncoder().encode(["testValue": completelyInvalidArray]))!
    static let completelyInvalidArrayJSON = String(data: completelyInvalidArrayJSONData, encoding: .utf8)!
    
    static let emptyArray: [Entity] = []
    static let emptyArrayJSONData = (try? JSONEncoder().encode(["testValue": emptyArray]))!
    static let emptyArrayJSON = String(data: emptyArrayJSONData, encoding: .utf8)!
    
    static let invalidTypeJSONData = #"{"testValue":12345}"#.data(using: .utf8)!
}
