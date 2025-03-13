import XCTest
@testable import BRCoding

final class BRCodingTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    internal static let nullLiteralJSON = #"{"testValue":null}"#
    internal static let nullLiteralJSONData = nullLiteralJSON.data(using: .utf8)!
    internal static let missingFieldJSON = #"{}"#
    internal static let missingFieldJSONData = missingFieldJSON.data(using: .utf8)!
}
