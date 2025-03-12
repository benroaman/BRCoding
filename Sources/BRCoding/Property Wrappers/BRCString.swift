//
//  BRCString.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

// MARK: Optional
/// Wraps an optonal string, If the value is absent, invalid, null, or otherwise fails to decode, it will default to nil.
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

// MARK: Optional Strict
/// Wraps an optonal string, If the value is absent, empty, whitespace-only, invalid, null, or otherwise fails to decode, it will default to nil.
/// - If decoding fails, no error will be thrown to the parent object.
/// - Trims leading and trailing whitespace. Decode input considered invalid if it is empty after trimming.
/// - EX: @BRCStringOptionalStrict private(set) var someString: String?
@propertyWrapper
public struct BRCStringOptionalStrict: Codable {
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCStringOptionalStrict.Type, forKey key: Self.Key) throws -> BRCStringOptionalStrict {
        return try decodeIfPresent(type, forKey: key) ?? BRCStringOptionalStrict(wrappedValue: nil)
    }
}

// MARK: Required
/// Wraps a string. If the value is absent, invalid, null, or otherwise fails to decode, throws an error.
/// - EX: @BRCStringRequired private(set) var someString: String
/// - Warning: basically redundant to using "let someString: String"
@propertyWrapper
public struct BRCStringRequired: Codable {
    public var wrappedValue: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

// MARK: Required Strict
/// Wraps an optonal string, If the value is absent, empty, whitespace-only, invalid, null, or otherwise fails to decode, throws an error.
/// - Trims leading and trailing whitespace. Decode input considered invalid if it is empty after trimming.
/// - EX: @BRCStringRequiredStrict private(set) var someString: String?
@propertyWrapper
public struct BRCStringRequiredStrict: Codable {
    public var wrappedValue: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let value = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !value.isEmpty {
            self.wrappedValue = value
        } else {
            throw DecodingError.valueNotFound(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required string cannot be empty"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
