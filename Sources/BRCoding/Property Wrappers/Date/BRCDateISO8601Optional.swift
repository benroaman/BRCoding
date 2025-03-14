//
//  BRCDateISO8601Optional.swift
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
/// - Example: @BRCDateISO8601Optional private(set) var someDate: Date?
@propertyWrapper
public struct BRCDateISO8601Optional: Codable {
    public var wrappedValue: Date?
    public let originalString: String?
    
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.originalString)
    }
}

public extension KeyedDecodingContainer {
    func decode(_ type: BRCDateISO8601Optional.Type, forKey key: Self.Key) throws -> BRCDateISO8601Optional {
        return try decodeIfPresent(type, forKey: key) ?? BRCDateISO8601Optional(wrappedValue: nil)
    }
}
