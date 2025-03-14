//
//  BRCBoolNonNullableDefaultFalse.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `Bool` that can be decoded from literal booleans, valid integers, and valid strings. If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `false`.
/// - Valid decode values are `true`, `false`, `1`, `0`, `"true"`, `"false"`, `"1"`, and `"0"`.
/// - `Ex: @BRCBoolNonNullableDefaultFalse private(set) var someBool: Bool`
@propertyWrapper
public struct BRCBoolNonNullableDefaultFalse: Codable {
    public var wrappedValue: Bool
    
    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = false
            return
        }
        
        if let value = try? container.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? container.decode(Int.self), intValue == 1 {
            self.wrappedValue = true
        } else if let strValue = try? container.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else if strValue == "1" {
                self.wrappedValue = true
            } else {
                self.wrappedValue = false
            }
        } else {
            self.wrappedValue = false
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCBoolNonNullableDefaultFalse.Type, forKey key: Self.Key) throws -> BRCBoolNonNullableDefaultFalse {
        return try decodeIfPresent(type, forKey: key) ?? BRCBoolNonNullableDefaultFalse(wrappedValue: false)
    }
}
