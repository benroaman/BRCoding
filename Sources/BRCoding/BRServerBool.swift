//
//  BRServerBool.swift
//
//
//  Created by Ben Roaman on 3/9/25.
//

import Foundation

@propertyWrapper
struct BRNonNullableServerBoolDefaultFalse {
    var wrappedValue: Bool
}

extension BRNonNullableServerBoolDefaultFalse: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? (try? decoder.singleValueContainer())?.decode(Int.self), intValue == 1 {
            self.wrappedValue = true
        } else if let strValue = try? (try? decoder.singleValueContainer())?.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else if strValue == "1" {
                self.wrappedValue = true
            } else {
                self.wrappedValue = false
            }
        } else {
            self.wrappedValue = false
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BRNonNullableServerBoolDefaultFalse.Type, forKey key: Self.Key) throws -> BRNonNullableServerBoolDefaultFalse {
        return try decodeIfPresent(type, forKey: key) ?? BRNonNullableServerBoolDefaultFalse(wrappedValue: false)
    }
}

@propertyWrapper
struct BRNonNullableServerBoolDefaultTrue {
    var wrappedValue: Bool
}

extension BRNonNullableServerBoolDefaultTrue: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? (try? decoder.singleValueContainer())?.decode(Int.self), intValue == 0 {
            self.wrappedValue = false
        } else if let strValue = try? (try? decoder.singleValueContainer())?.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else if strValue == "0" {
                self.wrappedValue = false
            } else {
                self.wrappedValue = true
            }
        } else {
            self.wrappedValue = true
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BRNonNullableServerBoolDefaultTrue.Type, forKey key: Self.Key) throws -> BRNonNullableServerBoolDefaultTrue {
        return try decodeIfPresent(type, forKey: key) ?? BRNonNullableServerBoolDefaultTrue(wrappedValue: true)
    }
}

@propertyWrapper
struct BROptionalServerBool {
    var wrappedValue: Bool?
}

extension BROptionalServerBool: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? (try? decoder.singleValueContainer())?.decode(Int.self) {
            switch intValue {
            case 0: self.wrappedValue = false
            case 1: self.wrappedValue = true
            default: self.wrappedValue = nil
            }
        } else if let strValue = try? (try? decoder.singleValueContainer())?.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else {
                switch strValue {
                case "0": self.wrappedValue = false
                case "1": self.wrappedValue = true
                default: self.wrappedValue = nil
                }
            }
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
    func decode(_ type: BROptionalServerBool.Type, forKey key: Self.Key) throws -> BROptionalServerBool {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalServerBool(wrappedValue: nil)
    }
}

@propertyWrapper
struct BRRequiredServerBool {
    var wrappedValue: Bool
}

extension BRRequiredServerBool: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? (try? decoder.singleValueContainer())?.decode(Int.self) {
            switch intValue {
            case 0: self.wrappedValue = false
            case 1: self.wrappedValue = true
            default: throw DecodingError.valueNotFound(Bool.self, .init(codingPath: decoder.codingPath, debugDescription: "Int Representation not valid Bool"))
            }
        } else if let strValue = try? (try? decoder.singleValueContainer())?.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else {
                switch strValue {
                case "0": self.wrappedValue = false
                case "1": self.wrappedValue = true
                default: throw DecodingError.valueNotFound(Bool.self, .init(codingPath: decoder.codingPath, debugDescription: "String Representation not valid Bool"))
                }
            }
        } else {
            throw DecodingError.valueNotFound(Bool.self, .init(codingPath: decoder.codingPath, debugDescription: "No Bool-equivalent value"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

@propertyWrapper
struct BROptionalNullOmittingServerBool {
    var wrappedValue: Bool?
}

extension BROptionalNullOmittingServerBool: Codable {
    init(from decoder: Decoder) throws {
        if let value = try? (try? decoder.singleValueContainer())?.decode(Bool.self) {
            self.wrappedValue = value
        } else if let intValue = try? (try? decoder.singleValueContainer())?.decode(Int.self) {
            switch intValue {
            case 0: self.wrappedValue = false
            case 1: self.wrappedValue = true
            default: self.wrappedValue = nil
            }
        } else if let strValue = try? (try? decoder.singleValueContainer())?.decode(String.self) {
            if let boolValue = Bool(strValue) {
                self.wrappedValue = boolValue
            } else {
                switch strValue {
                case "0": self.wrappedValue = false
                case "1": self.wrappedValue = true
                default: self.wrappedValue = nil
                }
            }
        } else {
            self.wrappedValue = nil
        }
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: BROptionalNullOmittingServerBool.Type, forKey key: Self.Key) throws -> BROptionalNullOmittingServerBool {
        return try decodeIfPresent(type, forKey: key) ?? BROptionalNullOmittingServerBool(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    mutating func encode(_ value: BROptionalNullOmittingServerBool, forKey key: Self.Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}
