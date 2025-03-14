//
//  BRCBoolOptional.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `Bool` that can be decoded from literal booleans, valid integers, and valid strings. If the value is absent, invalid, or otherwise fails to decode, it will default to `nil` without causing the decoding of the parent object to fail.
/// - Valid decode values are `true`, `false`, `1`, `0`, `"true"`, `"false"`, `"1"`, and `"0"`.
/// - If `wrappedValue` is `nil`, encodes as a `null` literal.
/// - EX: `@BRCBoolOptional private(set) var someBool: Bool?`
@propertyWrapper
public struct BRCBoolOptional: Codable {
    public var wrappedValue: Bool?
    
    public init(wrappedValue: Bool? = nil) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = nil
            return
        }
        
        if let value = try? container.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? container.decode(Int.self) {
            switch intValue {
            case 0: self.wrappedValue = false
            case 1: self.wrappedValue = true
            default: self.wrappedValue = nil
            }
        } else if let strValue = try? container.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else {
                switch strValue {
                case "0": self.wrappedValue = false
                case "1": self.wrappedValue = true
                default: self.wrappedValue = nil
                }
            }
        } else {
            self.wrappedValue = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCBoolOptional.Type, forKey key: Self.Key) throws -> BRCBoolOptional {
        return try decodeIfPresent(type, forKey: key) ?? BRCBoolOptional(wrappedValue: nil)
    }
}
