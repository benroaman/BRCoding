//
//  BRCStringOptional.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps an optonal string. If the value is absent, invalid, null, or otherwise fails to decode, it will default to nil.
/// - If decoding fails, no error will be thrown to the parent object.
/// - EX: @BRCStringOptional private(set) var someString: String?
@propertyWrapper
public struct BRCStringOptional: Codable {
    public var wrappedValue: String?
    
    public init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        self.wrappedValue = try? container?.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCStringOptional.Type, forKey key: Self.Key) throws -> BRCStringOptional {
        return try decodeIfPresent(type, forKey: key) ?? BRCStringOptional(wrappedValue: nil)
    }
}
