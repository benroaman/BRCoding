//
//  BRServerURL.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

// MARK: Optional
///
///
///
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
///
///
///
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

// MARK: Required
///
///
///
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
