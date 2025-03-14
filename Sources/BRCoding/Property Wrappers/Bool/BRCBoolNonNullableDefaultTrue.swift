//
//  BRCBoolNonNullableDefaultTrue.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `Bool` that can be decoded from literal booleans, valid integers, and valid strings. If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `true`.
/// - Valid decode values are `true`, `false`, `1`, `0`, `"true"`, `"false"`, `"1"`, and `"0"`.
/// - `EX: @BRCBoolNonNullableDefaultTrue private(set) var someBool: Bool`
@propertyWrapper
public struct BRCBoolNonNullableDefaultTrue: Codable {
    public var wrappedValue: Bool
    
    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = true
            return
        }
        
        if let value = try? container.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? container.decode(Int.self), intValue == 0 {
            self.wrappedValue = false
        } else if let strValue = try? container.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else if strValue == "0" {
                self.wrappedValue = false
            } else {
                self.wrappedValue = true
            }
        } else {
            self.wrappedValue = true
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCBoolNonNullableDefaultTrue.Type, forKey key: Self.Key) throws -> BRCBoolNonNullableDefaultTrue {
        return try decodeIfPresent(type, forKey: key) ?? BRCBoolNonNullableDefaultTrue(wrappedValue: true)
    }
}
