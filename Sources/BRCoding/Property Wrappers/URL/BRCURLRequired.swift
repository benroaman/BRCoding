//
//  BRCURLRequired.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

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
