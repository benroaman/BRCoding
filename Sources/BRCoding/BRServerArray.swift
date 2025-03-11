//
//  File.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BRNonNullableServerArray<V: Codable> {
    var wrappedValue: [V]
}

extension BRNonNullableServerArray: Codable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        if let value = try? container?.decode([V].self) {
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
    func decode<T>(_ type: BRNonNullableServerArray<T>.Type, forKey key: Self.Key) throws -> BRNonNullableServerArray<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BRNonNullableServerArray<T>(wrappedValue: [])
    }
}
