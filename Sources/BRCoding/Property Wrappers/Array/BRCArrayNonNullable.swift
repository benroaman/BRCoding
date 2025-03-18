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
public struct BRCArrayNonNullable<V: Codable>: Codable {
    public var wrappedValue: [V]
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        if let value = try? container?.decode([V].self) {
            wrappedValue = value
        } else {
            wrappedValue = []
        }
    }
    
    public init(wrappedValue: [V]) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCArrayNonNullable<T>.Type, forKey key: Self.Key) throws -> BRCArrayNonNullable<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BRCArrayNonNullable<T>(wrappedValue: [])
    }
}
