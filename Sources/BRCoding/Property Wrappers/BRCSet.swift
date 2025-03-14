//
//  BRCSet.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

// MARK: Non Nullable
/// Wraps a `Set`. If the value is absent, invalid, `null`, or otherwise fails to decode, defaults to `[]`.
/// - If decoding fails, will not throw an error
/// - Input redundancies are automatically removed, e.g. `[1, 1, 2, 2]` becomes `[1, 2]`
/// - EX: `@BRCSetNonNullable private(set) var someIntSet: Set<Int>`
@propertyWrapper
public struct BRCSetNonNullable<V: Codable & Hashable>: Codable {
    public var wrappedValue: Set<V>
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        if let value = try? container?.decode(Set<V>.self) {
            wrappedValue = value
        } else {
            wrappedValue = []
        }
    }
    
    public init(wrappedValue: Set<V>) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCSetNonNullable<T>.Type, forKey key: Self.Key) throws -> BRCSetNonNullable<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BRCSetNonNullable<T>(wrappedValue: [])
    }
}
