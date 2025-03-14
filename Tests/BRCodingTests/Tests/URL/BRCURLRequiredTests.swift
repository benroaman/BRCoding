//
//  BRCURLRequiredTests.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import XCTest
@testable import BRCoding

final class BRCURLRequiredTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Type
    private struct URLRequired: Codable {
        @BRCURLRequired private(set) var testValue: URL
    }
    
    // MARK: Decoding Tests
    func testRequired() {
        if let validURLTest = try? decoder.decode(URLRequired.self, from: URLTestData.validURLJSONData) {
            XCTAssert(validURLTest.testValue.absoluteString == URLTestData.validURLString, "Valid URL decoded incorrectly")
            
            if let encoded = try? encoder.encode(validURLTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == URLTestData.validURLJSON, "Encoding valid URL produced bad JSON")
                
                if let decoded = try? decoder.decode(URLRequired.self, from: encoded) {
                    XCTAssert(decoded.testValue.absoluteString == URLTestData.validURLString, "Encoded valid URL decoded incorrectly")
                } else {
                    XCTFail("Encoded valid URL failed to decode")
                }
            } else {
                XCTFail("Valid URL failed to encode")
            }
        } else {
            XCTFail("Valid URL failed to decode")
        }
        
        if let _ = try? decoder.decode(URLRequired.self, from: URLTestData.invalidURLJSONData) {
            XCTFail("Invalid URL decoded but should have failed")
        }
        
        if let _ = try? decoder.decode(URLRequired.self, from: URLTestData.invalidTypeJSONData) {
            XCTFail("Invalid type decoded but should have failed")
        }
        
        if let _ = try? decoder.decode(URLRequired.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Null literal decoded but should have failed")
        }
        
        if let _ = try? decoder.decode(URLRequired.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Missing field decoded but should have failed")
        }
    }
    
    // MARK: Encoding Tests
}
