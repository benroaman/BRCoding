//
//  BRCBoolOptionalNullOmitting.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a Bool that can be decoded from literal booleans, valid integers, and valid strings. If the value is absent, invalid, null, or otherwise fails to decode, it will default to nil without causing the decoding of the parent object to fail. It will not encode if the wrappedValue is nil.
/// - Valid decode values are true, false, 1, 0, "true", "false", "1", and "0".
/// - If wrappedValue is nil, does not encode
/// - Example: @BRCBoolOptionalNullOmitting private(set) var someBool: Bool?
@propertyWrapper
public struct BRCBoolOptionalNullOmitting: Codable {
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
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCBoolOptionalNullOmitting.Type, forKey key: Self.Key) throws -> BRCBoolOptionalNullOmitting {
        return try decodeIfPresent(type, forKey: key) ?? BRCBoolOptionalNullOmitting(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCBoolOptionalNullOmitting, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}
