//
//  BRServerDate.swift
//
//
//  Created by Ben Roaman on 3/10/25.
//

import Foundation

// MARK: Optional ISO8601 Date
///
///
///
@propertyWrapper
struct BROptionalServerISO8601Date {
    var wrappedValue: Date?
}

extension BROptionalServerISO8601Date: Codable {
    init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let dateStr = try? container.decode(String.self) {
            self.wrappedValue = try? Date(dateStr, strategy: .iso8601)
//            self.wrappedValue = BRCoding.iso8601DateFormatter.date(from: dateStr)
        } else {
            self.wrappedValue = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue?.ISO8601Format())
//        if let date = self.wrappedValue {
//            try container.encode(BRCoding.iso8601DateFormatter.string(from: date))
//        } else {
//            try container.encode(self.wrappedValue)
//        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalServerISO8601Date.Type, forKey key: Self.Key) throws -> BROptionalServerISO8601Date {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalServerISO8601Date(wrappedValue: nil)
    }
}

// MARK: Optional Null Omitting ISO8601 Date
///
///
///
@propertyWrapper
struct BROptionalNullOmittingServerISO8601Date {
    var wrappedValue: Date?
}

extension BROptionalNullOmittingServerISO8601Date: Codable {
    init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let dateStr = try? container.decode(String.self) {
            self.wrappedValue = try? Date(dateStr, strategy: .iso8601)
        } else {
            self.wrappedValue = nil
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalNullOmittingServerISO8601Date.Type, forKey key: Self.Key) throws -> BROptionalNullOmittingServerISO8601Date {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalNullOmittingServerISO8601Date(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    mutating func encode(_ value: BROptionalNullOmittingServerISO8601Date, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue?.ISO8601Format(), forKey: key)
//        if let date = value.wrappedValue {
//            try encode(BRCoding.iso8601DateFormatter.string(from: date), forKey: key)
//        } else {
//            try encodeIfPresent(value.wrappedValue, forKey: key)
//        }
    }
}

// MARK: Required ISO8601 Date
@propertyWrapper
struct BRRequiredServerISO8601Date {
    var wrappedValue: Date
}

extension BRRequiredServerISO8601Date: Codable {
    init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let dateStr = try? container.decode(String.self), let date = try? Date(dateStr, strategy: .iso8601) {
            self.wrappedValue = date
        } else {
            let value = try (try decoder.singleValueContainer()).decode(String.self)
            throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required date str does not match ISO8601: \(value)"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue.ISO8601Format())
//        try container.encode(BRCoding.iso8601DateFormatter.string(from: self.wrappedValue))
    }
}

// MARK: Optional Standard Epoch Date
///
///
///
@propertyWrapper
struct BROptionalStandardEpochDate {
    var wrappedValue: Date?
}

extension BROptionalStandardEpochDate: Codable {
    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = nil
            return
        }
        
        if let epoch = try? container.decode(TimeInterval.self) {
            self.wrappedValue = Date(timeIntervalSince1970: epoch)
        } else if let epochStr = try? container.decode(String.self), let epoch = TimeInterval(epochStr) {
            self.wrappedValue = Date(timeIntervalSince1970: epoch)
        } else {
            self.wrappedValue = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let date = self.wrappedValue {
            try container.encode(date.timeIntervalSince1970)
        } else {
            try container.encode(self.wrappedValue)
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalStandardEpochDate.Type, forKey key: Self.Key) throws -> BROptionalStandardEpochDate {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalStandardEpochDate(wrappedValue: nil)
    }
}

// MARK: Optional Null Omitting Standard Epoch Date
///
///
///
@propertyWrapper
struct BROptionalNullOmittingStandardEpochDate {
    var wrappedValue: Date?
}

extension BROptionalNullOmittingStandardEpochDate: Codable {
    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = nil
            return
        }
        
        if let epoch = try? container.decode(TimeInterval.self) {
            self.wrappedValue = Date(timeIntervalSince1970: epoch)
        } else if let epochStr = try? container.decode(String.self), let epoch = TimeInterval(epochStr) {
            self.wrappedValue = Date(timeIntervalSince1970: epoch)
        } else {
            self.wrappedValue = nil
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalNullOmittingStandardEpochDate.Type, forKey key: Self.Key) throws -> BROptionalNullOmittingStandardEpochDate {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalNullOmittingStandardEpochDate(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    mutating func encode(_ value: BROptionalNullOmittingStandardEpochDate, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue?.timeIntervalSince1970, forKey: key)
    }
}

// MARK: Required Standard Epoch Date
///
///
///
@propertyWrapper
struct BRRequiredServerStandardEpochDate {
    var wrappedValue: Date
}

extension BRRequiredServerStandardEpochDate: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let epoch = try? container.decode(TimeInterval.self) {
            self.wrappedValue = Date(timeIntervalSince1970: epoch)
        } else if let epochStr = try? container.decode(String.self), let epoch = TimeInterval(epochStr) {
            self.wrappedValue = Date(timeIntervalSince1970: epoch)
        } else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required date not a valid epoch"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue.timeIntervalSince1970)
//        try container.encode(BRCoding.iso8601DateFormatter.string(from: self.wrappedValue))
    }
}

// MARK: Optional Apple Epoch Date
///
///
///
@propertyWrapper
struct BROptionalAppleEpochDate {
    var wrappedValue: Date?
}

extension BROptionalAppleEpochDate: Codable {
    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = nil
            return
        }
        
        if let epoch = try? container.decode(TimeInterval.self) {
            self.wrappedValue = Date(timeIntervalSinceReferenceDate: epoch)
        } else if let epochStr = try? container.decode(String.self), let epoch = TimeInterval(epochStr) {
            self.wrappedValue = Date(timeIntervalSinceReferenceDate: epoch)
        } else {
            self.wrappedValue = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let date = self.wrappedValue {
            try container.encode(date.timeIntervalSinceReferenceDate)
        } else {
            try container.encode(self.wrappedValue)
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalAppleEpochDate.Type, forKey key: Self.Key) throws -> BROptionalAppleEpochDate {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalAppleEpochDate(wrappedValue: nil)
    }
}

// MARK: Optional Null Omitting Apple Epoch Date
///
///
///
@propertyWrapper
struct BROptionalNullOmittingAppleEpochDate {
    var wrappedValue: Date?
}

extension BROptionalNullOmittingAppleEpochDate: Codable {
    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            self.wrappedValue = nil
            return
        }
        
        if let epoch = try? container.decode(TimeInterval.self) {
            self.wrappedValue = Date(timeIntervalSinceReferenceDate: epoch)
        } else if let epochStr = try? container.decode(String.self), let epoch = TimeInterval(epochStr) {
            self.wrappedValue = Date(timeIntervalSinceReferenceDate: epoch)
        } else {
            self.wrappedValue = nil
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalNullOmittingAppleEpochDate.Type, forKey key: Self.Key) throws -> BROptionalNullOmittingAppleEpochDate {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalNullOmittingAppleEpochDate(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    mutating func encode(_ value: BROptionalNullOmittingAppleEpochDate, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue?.timeIntervalSinceReferenceDate, forKey: key)
    }
}

// MARK: Required Apple Epoch Date
///
///
///
@propertyWrapper
struct BRRequiredServerAppleEpochDate {
    var wrappedValue: Date
}

extension BRRequiredServerAppleEpochDate: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let epoch = try? container.decode(TimeInterval.self) {
            self.wrappedValue = Date(timeIntervalSinceReferenceDate: epoch)
        } else if let epochStr = try? container.decode(String.self), let epoch = TimeInterval(epochStr) {
            self.wrappedValue = Date(timeIntervalSinceReferenceDate: epoch)
        } else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: "Required date not a valid epoch"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue.timeIntervalSinceReferenceDate)
    }
}
