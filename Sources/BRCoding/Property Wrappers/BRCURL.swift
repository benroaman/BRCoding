//
//  BRServerURL.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

// MARK: Optional
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

// MARK: Optional Null Omitting
/// Wraps a `URL` decoded from a string. If the string is absent, invalid, `null`, or otherwise fails to decode, it will default to `nil`.
/// - If decoding fails, will not throw an error
/// - If `nil`, does not encode
/// - EX: `@BRCURLOptionalNullOmitting private(set) var someURL: URL?`
@propertyWrapper
public struct BRCURLOptionalNullOmitting: Codable {
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
    func decode(_ type: BRCURLOptionalNullOmitting.Type, forKey key: Self.Key) throws -> BRCURLOptionalNullOmitting {
        return try decodeIfPresent(type, forKey: key) ?? BRCURLOptionalNullOmitting(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCURLOptionalNullOmitting, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}


// MARK: Required
/// Wraps a `URL` decoded from a string. If the string is absent, invalid, `null`, or otherwise fails to decode, throws an error.
/// - EX: `@BRCURLRequired private(set) var someURL: URL`
@propertyWrapper
public struct BRCURLRequired: Codable {
    public var wrappedValue: URL
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let urlStr = try container.decode(String.self)
        
        if let value = URL(string: urlStr) {
            self.wrappedValue = value
        } else {
            throw DecodingError.valueNotFound(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required URL not valid: \(urlStr)"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.absoluteString)
    }
}
