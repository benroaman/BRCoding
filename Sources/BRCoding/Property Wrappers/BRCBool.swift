//
//  BRCBool.swift
//
//
//  Created by Ben Roaman on 3/9/25.
//

import Foundation

// MARK: Non Nullable Default False
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

// MARK: Non Nullable Default False
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

// MARK: Optional
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

// MARK: Required
/// Wraps a Bool that can be decoded from literal booleans, valid integers, and valid strings. If the value is absent, invalid, null, or otherwise fails to decode, it will throw an error potentially causing decoding of the parent object to fail.
/// - Valid decode values are true, false, 1, 0, "true", "false", "1", and "0".
/// - Example: @BRCBoolRequired private(set) var someBool: Bool
@propertyWrapper
public struct BRCBoolRequired: Codable {
    public var wrappedValue: Bool
    
    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? container.decode(Int.self) {
            switch intValue {
            case 0: self.wrappedValue = false
            case 1: self.wrappedValue = true
            default: throw DecodingError.typeMismatch(Bool.self, .init(codingPath: decoder.codingPath, debugDescription: "Int Representation not valid Bool"))
            }
        } else if let strValue = try? container.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else {
                switch strValue {
                case "0": self.wrappedValue = false
                case "1": self.wrappedValue = true
                default: throw DecodingError.typeMismatch(Bool.self, .init(codingPath: decoder.codingPath, debugDescription: "String Representation not valid Bool"))
                }
            }
        } else {
            throw DecodingError.valueNotFound(Bool.self, .init(codingPath: decoder.codingPath, debugDescription: "No Bool-equivalent value"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

// MARK: Optional Null Omitting
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
