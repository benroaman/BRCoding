// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

final class BRCoding {
    internal static let iso8601DateFormatter: ISO8601DateFormatter = {
        let result = ISO8601DateFormatter()
        result.formatOptions.insert(.withFractionalSeconds)
        result.timeZone = TimeZone.autoupdatingCurrent
        return result
    }()
}
