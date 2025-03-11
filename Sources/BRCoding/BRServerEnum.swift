//
//  File.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

protocol BRServerEnum: RawRepresentable, Codable {
    static var fallbackCase: Self { get }
}

@propertyWrapper
struct BRNonNullableServerEnum<V: BRServerEnum> {
    var wrappedValue: V
}

extension BRNonNullableServerEnum: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(V.self) {
            self.wrappedValue = value
        } else {
            self.wrappedValue = V.fallbackCase
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BRNonNullableServerEnum<T>.Type, forKey key: Self.Key) throws -> BRNonNullableServerEnum<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRNonNullableServerEnum<T>(wrappedValue: T.fallbackCase)
    }
}

@propertyWrapper
struct BRNullableServerEnum<V: BRServerEnum> {
    var wrappedValue: V?
}

extension BRNullableServerEnum: Codable {
    init(from decoder: Decoder) throws { self.wrappedValue = try? (try? decoder.singleValueContainer())?.decode(V.self) }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BRNullableServerEnum<T>.Type, forKey key: Self.Key) throws -> BRNullableServerEnum<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRNullableServerEnum<T>(wrappedValue: nil)
    }
}
