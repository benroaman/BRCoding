//
//  File.swift
//  
//
//  Created by Ben Roaman on 3/13/25.
//

import XCTest
@testable import BRCoding

final class BRCArrayTests: XCTestCase {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private struct SelfValidatingEntity: BRCSelfValidatingEntity {
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
    }
    
    private let completelyValidArray: [SelfValidatingEntity] = [SelfValidatingEntity(id: 1, testInt: 123, testString: nil, kind: .int),
                                                                SelfValidatingEntity(id: 2, testInt: nil, testString: "Test", kind: .string)]
    
    private let partiallyValidArray: [SelfValidatingEntity] = [SelfValidatingEntity(id: 1, testInt: 123, testString: nil, kind: .int),
                                                               SelfValidatingEntity(id: 2, testInt: nil, testString: nil, kind: .string),
                                                               SelfValidatingEntity(id: 3, testInt: nil, testString: "Test", kind: .string)]
    
    private let completelyInvalidArray: [SelfValidatingEntity] = [SelfValidatingEntity(id: 1, testInt: nil, testString: nil, kind: .int),
                                                                  SelfValidatingEntity(id: 2, testInt: nil, testString: nil, kind: .string),
                                                                  SelfValidatingEntity(id: 3, testInt: nil, testString: nil, kind: .string)]
    
    private let emptyArray: [SelfValidatingEntity] = []
}
