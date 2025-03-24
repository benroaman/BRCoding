//
//  BRCArrayNonNullableFailureDropping.swift
//
//
//  Created by Ben Roaman on 3/23/25.
//

import Foundation

// MARK: Non Nullable Validated
/// Wraps an array of `Codable` conforming entities. If the value is absent, invalid, `null`, or otherwise fails to decode, it will default to `[]`.
/// - If any value within the decoding array fails to decode it is omitted, and decoding will continue for the rest of the content of the array.
/// - EX: `@BRCArrayNonNullableFailureDropping private(set) var someArray: [Int]`
@propertyWrapper
public struct BRCArrayNonNullableFailureDropping<T: Codable>: Codable {
    public var wrappedValue: [T]
    
    public init(from decoder: Decoder) throws {
        guard var container = try? decoder.unkeyedContainer() else {
            self.wrappedValue = []
            return
        }
        
        var elements = [T]()
        
        while !container.isAtEnd {
            do {
                elements.append(try container.decode(T.self))
            } catch {
                #if DEBUG
                print("Dropping invalid instance of Server Entity \(T.self): \(error)")
                #endif
                _ = try? container.decode(AnyDecodable.self)
            }
        }
        
        self.wrappedValue = elements
    }
    
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension BRCArrayNonNullableFailureDropping {
    private struct AnyDecodable: Decodable { }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: BRCArrayNonNullableFailureDropping<T>.Type, forKey key: Self.Key) throws -> BRCArrayNonNullableFailureDropping<T> where T : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? BRCArrayNonNullableFailureDropping<T>(wrappedValue: [])
    }
}
