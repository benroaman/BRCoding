//
//  BRServerStringyValue.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BROptionalServerStringyValue<V: LosslessStringConvertible & Codable> {
    var wrappedValue: V?
}

extension BROptionalServerStringyValue: Codable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        if let properValue = try? container?.decode(V.self) {
            self.wrappedValue = properValue
        } else if let strValue = try? container?.decode(String.self) {
            self.wrappedValue = V(strValue)
        } else {
            self.wrappedValue = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: BROptionalServerStringyValue<T>.Type, forKey key: Self.Key) throws -> BROptionalServerStringyValue<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalServerStringyValue<T>(wrappedValue: nil)
    }
}

@propertyWrapper
struct BRRequiredServerStringyValue<V: LosslessStringConvertible & Codable> {
    var wrappedValue: V
}

extension BRRequiredServerStringyValue: Codable {
    init(from decoder: Decoder) throws {
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
