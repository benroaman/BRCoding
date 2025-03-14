//
//  BRCArrayNonNullable.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

//MARK: Non Nullable
/// Wraps an array of `Codable`. If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `[]`.
/// - EX: `@BRCArrayNonNullable private(set) var someIntArray: [Int]`
@propertyWrapper
struct BRCArrayNonNullable<V: Codable> {
    var wrappedValue: [V]
}

extension BRCArrayNonNullable: Codable {
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
    func decode<T>(_ type: BRCArrayNonNullable<T>.Type, forKey key: Self.Key) throws -> BRCArrayNonNullable<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BRCArrayNonNullable<T>(wrappedValue: [])
    }
}
