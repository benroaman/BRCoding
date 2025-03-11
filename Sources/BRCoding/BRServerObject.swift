//
//  File.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BROptionalServerObject<V: Codable> {
    var wrappedValue: V?
}

extension BROptionalServerObject: Codable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        wrappedValue = try? container?.decode(V.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BROptionalServerObject<T>.Type, forKey key: Self.Key) throws -> BROptionalServerObject<T> where T : Decodable {
        try decodeIfPresent(type, forKey: key) ?? BROptionalServerObject<T>(wrappedValue: nil)
    }
}

protocol BRServerObject: Codable {
    static var backupCase: Self { get }
}

@propertyWrapper
struct BRNonNullableServerObject<V: BRServerObject> {
    var wrappedValue: V
}

extension BRNonNullableServerObject: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(V.self) {
            self.wrappedValue = value
        } else {
            self.wrappedValue = V.backupCase
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BRNonNullableServerObject<T>.Type, forKey key: Self.Key) throws -> BRNonNullableServerObject<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRNonNullableServerObject<T>(wrappedValue: T.backupCase)
    }
}
