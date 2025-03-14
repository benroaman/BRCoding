//
//  BRCStringyValueRequired.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a `LosslessStringConvertible` (e.g. `Int`, `Double`). If the value is absent, invalid, `null`, or otherwise fails to decode, throws an error.
/// - EX: `@BRCStringyValueRequired private(set) var foo: Int`
@propertyWrapper
public struct BRCStringyValueRequired<V: LosslessStringConvertible & Codable>: Codable {
    public var wrappedValue: V
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let properValue = try? container.decode(V.self) {
            self.wrappedValue = properValue
        } else {
            let strValue = try container.decode(String.self)
            if let unstrungValue = V(strValue) {
                self.wrappedValue = unstrungValue
            } else {
                throw DecodingError.valueNotFound(V.self, .init(codingPath: decoder.codingPath, debugDescription: "String representation incompatible with underlying type"))
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
