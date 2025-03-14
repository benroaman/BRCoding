//
//  BRCStringyValueOptionalNullOmitting.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps an `Int` or `Double`. If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `nil`.
/// - Does not throw an error if decoding fails.
/// - If `nil`, does not encode.
/// - Warning: Currently only supports `Int` and `Double`, but could support any `LosslessStringConvertible` in future.
/// - EX: `@BRCStringyValueOptionalNullOmitting private(set) var foo: Int?`
@propertyWrapper
public struct BRCStringyValueOptionalNullOmitting<V: LosslessStringConvertible & Codable>: Codable {
    public var wrappedValue: V?
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        if let properValue = try? container?.decode(V.self) {
            self.wrappedValue = properValue
        } else if let strValue = try? container?.decode(String.self) {
            self.wrappedValue = V(strValue)
        } else {
            self.wrappedValue = nil
        }
    }
    
    public init(wrappedValue: V?) {
        self.wrappedValue = wrappedValue
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCStringyValueOptionalNullOmitting<T>.Type, forKey key: Self.Key) throws -> BRCStringyValueOptionalNullOmitting<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRCStringyValueOptionalNullOmitting<T>(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCStringyValueOptionalNullOmitting<Int>, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
    
    mutating func encode(_ value: BRCStringyValueOptionalNullOmitting<Double>, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}
