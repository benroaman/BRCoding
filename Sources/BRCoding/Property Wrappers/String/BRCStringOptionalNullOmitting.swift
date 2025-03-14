//
//  BRCStringOptionalNullOmitting.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps an optonal string. If the value is absent, invalid, null, or otherwise fails to decode, it will default to nil.
/// - If decoding fails, no error will be thrown to the parent object.
/// - If nil, does not encode
/// - EX: @BRCStringOptionalNullOmitting private(set) var someString: String?
@propertyWrapper
public struct BRCStringOptionalNullOmitting: Codable {
    public var wrappedValue: String?
    
    public init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        self.wrappedValue = try? container?.decode(String.self)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCStringOptionalNullOmitting.Type, forKey key: Self.Key) throws -> BRCStringOptionalNullOmitting {
        return try decodeIfPresent(type, forKey: key) ?? BRCStringOptionalNullOmitting(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCStringOptionalNullOmitting, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}
