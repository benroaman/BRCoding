//
//  BRCStringRequired.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a string. If the value is absent, invalid, null, or otherwise fails to decode, throws an error.
/// - EX: @BRCStringRequired private(set) var someString: String
/// - Warning: basically the same as just using "let someString: String"
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
