//
//  BRCURLOptional.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `URL` decoded from a string. If the string is absent, invalid, `null`, or otherwise fails to decode, it will default to `nil`.
/// - If decoding fails, will not throw an error
/// - If `nil`, encodes a `null` literal
/// - EX: `@BRCURLOptional private(set) var someURL: URL?`
@propertyWrapper
public struct BRCURLOptional: Codable {
    public var wrappedValue: URL?
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        let urlStr = (try? container?.decode(String.self)) ?? ""
        
        self.wrappedValue = URL(string: urlStr)
    }
    
    public init(wrappedValue: URL?) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue?.absoluteString)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCURLOptional.Type, forKey key: Self.Key) throws -> BRCURLOptional {
        return try decodeIfPresent(type, forKey: key) ?? BRCURLOptional(wrappedValue: nil)
    }
}
