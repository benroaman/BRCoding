//
//  BRCStringOptionalStrictNullOmitting.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps an optonal string. If the value is absent, empty, whitespace-only, invalid, null, or otherwise fails to decode, it will default to nil.
/// - If decoding fails, no error will be thrown to the parent object.
/// - Trims leading and trailing whitespace. Decode input considered invalid if it is empty after trimming.
/// - If nil, does not encode.
/// - Warning: Can still contain an empty or whitespace string if initialized with the wrappedValue initializer.
/// - EX: @BRCStringOptionalStrictNullOmitting private(set) var someString: String?
@propertyWrapper
public struct BRCStringOptionalStrictNullOmitting: Codable {
    public var wrappedValue: String?
    
    public init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        guard let value = try? container?.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines) else {
            self.wrappedValue = nil
            return
        }
        
        self.wrappedValue = !value.isEmpty ? value : nil
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCStringOptionalStrictNullOmitting.Type, forKey key: Self.Key) throws -> BRCStringOptionalStrictNullOmitting {
        return try decodeIfPresent(type, forKey: key) ?? BRCStringOptionalStrictNullOmitting(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCStringOptionalStrictNullOmitting, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}
