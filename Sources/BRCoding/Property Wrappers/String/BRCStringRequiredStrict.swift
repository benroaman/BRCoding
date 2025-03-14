//
//  BRCStringRequiredStrict.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a string. If the value is absent, empty, whitespace-only, invalid, null, or otherwise fails to decode, throws an error.
/// - Trims leading and trailing whitespace. Decode input considered invalid if empty after trimming.
/// - Warning: Can still contain an empty or whitespace string if initialized with the wrappedValue initializer.
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
