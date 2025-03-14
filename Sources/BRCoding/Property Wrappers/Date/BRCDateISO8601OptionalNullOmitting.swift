//
//  BRCDateISO8601OptionalNullOmitting.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

/// Wraps a Date that can be decoded from a standard ISO8601 string, e.g. "1964-09-11T19:15:00-01:00". If the value is absent, invalid, null, or otherwise fails to decode, it will default to nil.
/// - If decoding fails, no error will be thrown to the parent object.
/// - Uses Date.init<T, Value>(_ value: Value, strategy: T) to interpret ISO8601 strings
/// - If initialized from decoder, maintains a reference to the original ISO8601 string to use in encoding, and for reference to the original timezone and format.
/// - If initialized with a Date, encoding will produce an ISO8601 UTC string, e.g. "1964-09-11T20:15:00Z".
/// - If wrappedValue is nil, will not encode anything
/// - Example: @BRCDateISO8601OptionalNullOmitting private(set) var someDate: Date?
@propertyWrapper
public struct BRCDateISO8601OptionalNullOmitting: Codable {
    public var wrappedValue: Date?
    public var originalString: String?
    
    public init(wrappedValue: Date? = nil) {
        self.wrappedValue = wrappedValue
        self.originalString = wrappedValue?.ISO8601Format()
    }
    
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let dateStr = try? container.decode(String.self), let date = try? Date(dateStr, strategy: .iso8601) {
            self.wrappedValue = date
            self.originalString = dateStr
        } else {
            self.wrappedValue = nil
            self.originalString = nil
        }
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCDateISO8601OptionalNullOmitting.Type, forKey key: Self.Key) throws -> BRCDateISO8601OptionalNullOmitting {
        return try decodeIfPresent(type, forKey: key) ?? BRCDateISO8601OptionalNullOmitting(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: BRCDateISO8601OptionalNullOmitting, forKey key: Self.Key) throws {
        try encodeIfPresent(value.originalString, forKey: key)
    }
}
