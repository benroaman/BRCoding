//
//  File.swift
//  
//
//  Created by Ben Roaman on 3/15/25.
//

import Foundation

/// Wraps a `Set`. If the value is absent, invalid, `null`, or otherwise fails to decode, defaults to `[]`.
/// - If decoding fails, will not throw an error
/// - Input redundancies are automatically removed, e.g. `[1, 1, 2, 2]` becomes `[1, 2]`
/// - If set is empty, does not encode
/// - EX: `@BRCSetNonNullable private(set) var someIntSet: Set<Int>`
@propertyWrapper
public struct BRCSetNonNullableEmptyOmitting<V: Codable & Hashable>: Codable {
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
    func decode<T>(_ type: BRCSetNonNullableEmptyOmitting<T>.Type, forKey key: Self.Key) throws -> BRCSetNonNullableEmptyOmitting<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BRCSetNonNullableEmptyOmitting<T>(wrappedValue: [])
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<V: Codable & Hashable>(_ value: BRCSetNonNullableEmptyOmitting<V>, forKey key: Self.Key) throws {
        if value.wrappedValue.isEmpty {
            let replacement: Set<V>? = nil
            try encodeIfPresent(replacement, forKey: key)
        } else {
            try encodeIfPresent(value.wrappedValue, forKey: key)
        }
    }
}
