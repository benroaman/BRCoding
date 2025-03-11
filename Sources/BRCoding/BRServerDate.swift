//
//  BRServerDate.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

@propertyWrapper
struct BROptionalServerISO8601Date {
    var wrappedValue: Date?
}

extension BROptionalServerISO8601Date: Codable {
    init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let dateStr = try? container.decode(String.self) {
            self.wrappedValue = BRCoding.iso8601DateFormatter.date(from: dateStr)
        } else {
            self.wrappedValue = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let date = self.wrappedValue {
            try container.encode(BRCoding.iso8601DateFormatter.string(from: date))
        } else {
            try container.encode(self.wrappedValue)
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalServerISO8601Date.Type, forKey key: Self.Key) throws -> BROptionalServerISO8601Date {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalServerISO8601Date(wrappedValue: nil)
    }
}

@propertyWrapper
struct BRRequiredServerISO8601Date {
    var wrappedValue: Date
}

extension BRRequiredServerISO8601Date: Codable {
    init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let dateStr = try? container.decode(String.self), let date = BRCoding.iso8601DateFormatter.date(from: dateStr) {
            self.wrappedValue = date
        } else {
            let value = try (try decoder.singleValueContainer()).decode(String.self)
            throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required date str does not match ISO8601: \(value)"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(BRCoding.iso8601DateFormatter.string(from: self.wrappedValue))
    }
}
