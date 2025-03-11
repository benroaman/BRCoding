//
//  BRValidatedArray.swift
//  
//
//  Created by Ben Roaman on 3/9/25.
//

import Foundation

@propertyWrapper
struct BRValidatedArray<T: BRSelfValidatingServerEntity>: Codable {
    var wrappedValue: [T]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        var elements = [T]()
        
        while !container.isAtEnd {
            do {
                let element = try container.decode(ValidatedDecodableValue<T>.self).value
                elements.append(element)
            } catch {
                print("Dropping invalid instance of Server Entity \(T.self): \(error)")
                _ = try? container.decode(AnyDecodable.self)
            }
        }
        
        self.wrappedValue = elements
    }
    
    init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

// MARK: Support Types
extension BRValidatedArray {
    private struct AnyDecodable: Decodable { }
    
    private struct ValidatedDecodableValue<V: BRSelfValidatingServerEntity>: Codable {
        let value: V
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            value = try container.decode(V.self)
            if !value.isValid {
                throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Instance of \(type(of: V.self)) failed self validation"))
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BRValidatedArray<T>.Type, forKey key: Self.Key) throws -> BRValidatedArray<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRValidatedArray<T>(wrappedValue: [])
    }
}
