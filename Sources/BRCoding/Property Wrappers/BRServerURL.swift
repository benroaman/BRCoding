//
//  BRServerURL.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BROptionalServerURL {
    var wrappedValue: URL?
}

extension BROptionalServerURL: Codable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        
        let urlStr = (try? container?.decode(String.self)) ?? ""
        
        self.wrappedValue = URL(string: urlStr)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue?.absoluteString)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalServerURL.Type, forKey key: Self.Key) throws -> BROptionalServerURL {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalServerURL(wrappedValue: nil)
    }
}

@propertyWrapper
struct BRRequiredServerURL {
    var wrappedValue: URL
}

extension BRRequiredServerURL: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                
        let urlStr = try container.decode(String.self)
        
        if let value = URL(string: urlStr) {
            self.wrappedValue = value
        } else {
            throw DecodingError.valueNotFound(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required URL not valid: \(urlStr)"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.absoluteString)
    }
}
