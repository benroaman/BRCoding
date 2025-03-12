//
//  File.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BRNonNullableServerSet<V: Codable & Hashable> {
    private(set) var wrappedValue: Set<V>
}

extension BRNonNullableServerSet: Codable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        if let value = try? container?.decode(Set<V>.self) {
            wrappedValue = value
        } else {
            wrappedValue = []
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BRNonNullableServerSet<T>.Type, forKey key: Self.Key) throws -> BRNonNullableServerSet<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BRNonNullableServerSet<T>(wrappedValue: [])
    }
}
