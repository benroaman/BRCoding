//
//  BRCStringyValueOptional.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `LosslessStringConvertible` (e.g. `Int`, `Double`). If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `nil`.
/// - Does not throw an error if decoding fails.
/// - If `nil`, encodes as `null` literal.
/// - EX: `@BRCStringyValueOptional private(set) var foo: Int?`
@propertyWrapper
public struct BRCStringyValueOptional<V: LosslessStringConvertible & Codable>: Codable {
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCStringyValueOptional<T>.Type, forKey key: Self.Key) throws -> BRCStringyValueOptional<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRCStringyValueOptional<T>(wrappedValue: nil)
    }
}
