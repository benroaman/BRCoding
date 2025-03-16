//
//  BRCURLOptionalNullOmitting.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `URL` decoded from a string. If the string is absent, invalid, `null`, or otherwise fails to decode, it will default to `nil`.
/// - If decoding fails, will not throw an error
/// - If `nil`, does not encode
/// - EX: `@BRCURLOptionalNullOmitting private(set) var someURL: URL?`
@propertyWrapper
public struct BRCURLOptionalNullOmitting: Codable {
    public var wrappedValue: URL?
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        let urlStr = (try? container?.decode(String.self)) ?? ""
        
        self.wrappedValue = URL(string: urlStr)
    }
    
    public init(wrappedValue: URL?) {
        self.wrappedValue = wrappedValue
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCURLOptionalNullOmitting.Type, forKey key: Self.Key) throws -> BRCURLOptionalNullOmitting {
        return try decodeIfPresent(type, forKey: key) ?? BRCURLOptionalNullOmitting(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCURLOptionalNullOmitting, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}
