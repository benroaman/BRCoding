//
//  BRCBoolRequired.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

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
