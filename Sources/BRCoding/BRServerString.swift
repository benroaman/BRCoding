//
//  BRServerString.swift
//  
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BROptionalServerString {
    var wrappedValue: String?
}

extension BROptionalServerString: Codable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        guard let value = try? container?.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines) else {
            self.wrappedValue = nil
            return
        }
        
        self.wrappedValue = !value.isEmpty ? value : nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalServerString.Type, forKey key: Self.Key) throws -> BROptionalServerString {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalServerString(wrappedValue: nil)
    }
}

@propertyWrapper
struct BRRequiredServerString {
    var wrappedValue: String
}

extension BRRequiredServerString: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let value = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !value.isEmpty {
            self.wrappedValue = value
        } else {
            throw DecodingError.valueNotFound(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required string cannot be empty"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
