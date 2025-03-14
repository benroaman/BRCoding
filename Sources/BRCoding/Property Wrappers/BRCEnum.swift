//
//  BRCEnum.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

// MARK: Non Nullable
/// Wraps an `enum` that conforms to `BRCEnumWithFallback`. If the value is absent, invalid, `null`, or otherwise fails to decode, defaults to the `fallbackCase` defined by `V`.
/// - If decoding fails, will not throw an error
/// - EX: `@BRCEnumNonNullable private(set) var someEnum: SomeEnum`
@propertyWrapper
public struct BRCEnumNonNullable<V: BRCEnumWithFallback>: Codable {
    public var wrappedValue: V
    
    public init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(V.self) {
            self.wrappedValue = value
        } else {
            self.wrappedValue = V.fallbackCase
        }
    }
    
    public init(wrappedValue: V) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCEnumNonNullable<T>.Type, forKey key: Self.Key) throws -> BRCEnumNonNullable<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRCEnumNonNullable<T>(wrappedValue: T.fallbackCase)
    }
}
