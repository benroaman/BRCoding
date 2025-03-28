//
//  BRCArrayNonNullableValidated.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

// MARK: Non Nullable Validated
/// Wraps an array of `BRCSelfValidatingEntity`. If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `[]`.
/// - If any value within the decoding array fails to decode, or it's `isValid` evaluates to `false`, it is omitted, and decoding will continue for the rest of the content of the array.
/// - EX: `@BRCArrayValidated private(set) var someArray: [SelfValidatingEntity]`
@propertyWrapper
public struct BRCArrayNonNullableValidated<T: BRCSelfValidatingEntity>: Codable {
    public var wrappedValue: [T]
    
    public init(from decoder: Decoder) throws {
        guard var container = try? decoder.unkeyedContainer() else {
            self.wrappedValue = []
            return
        }
        
        var elements = [T]()
        
        while !container.isAtEnd {
            do {
                let element = try container.decode(ValidatedDecodableValue<T>.self).value
                elements.append(element)
            } catch {
                #if DEBUG
                print("Dropping invalid instance of Server Entity \(T.self): \(error)")
                #endif
                _ = try? container.decode(AnyDecodable.self)
            }
        }
        
        self.wrappedValue = elements
    }
    
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension BRCArrayNonNullableValidated {
    private struct AnyDecodable: Decodable { }
    
    private struct ValidatedDecodableValue<V: BRCSelfValidatingEntity>: Codable {
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

public extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCArrayNonNullableValidated<T>.Type, forKey key: Self.Key) throws -> BRCArrayNonNullableValidated<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRCArrayNonNullableValidated<T>(wrappedValue: [])
    }
}
