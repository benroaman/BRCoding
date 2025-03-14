//
//  BRCURLTests.swift
//  
//
//  Created by Ben Roaman on 3/13/25.
//

import XCTest
@testable import BRCoding

final class BRCURLTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Optional
    private struct URLOptional: Codable {
        @BRCURLOptional private(set) var testValue: URL?
    }
    
    func testOptional() {
        if let validURLTest = try? decoder.decode(URLOptional.self, from: URLTestData.validURLJSONData) {
            XCTAssert(validURLTest.testValue?.absoluteString == URLTestData.validURLString, "Valid URL decoded incorrectly")
            
            if let encoded = try? encoder.encode(validURLTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == URLTestData.validURLJSON, "Encoding valid URL produced bad JSON")
                
                if let decoded = try? decoder.decode(URLOptional.self, from: encoded) {
                    XCTAssert(decoded.testValue?.absoluteString == URLTestData.validURLString, "Encoded valid URL decoded incorrectly")
                } else {
                    XCTFail("Encoded valid URL failed to decode")
                }
            } else {
                XCTFail("Valid URL failed to encode")
            }
        } else {
            XCTFail("Valid URL failed to decode")
        }
        
        if let invalidURLTest = try? decoder.decode(URLOptional.self, from: URLTestData.invalidURLJSONData) {
            XCTAssert(invalidURLTest.testValue == nil, "Invalid URL decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidURLTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Encoding invalid URL produced bad JSON")
                
                if let decoded = try? decoder.decode(URLOptional.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid URL decoded incorrectly")
                } else {
                    XCTFail("Encoded invalid URL failed to decode")
                }
            } else {
                XCTFail("Invalid URL failed to encode")
            }
        } else {
            XCTFail("Invalid URL failed to decode")
        }
        
        if let invalidTypeTest = try? decoder.decode(URLOptional.self, from: URLTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == nil, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
        
        if let nullLiteralTest = try? decoder.decode(URLOptional.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
        
        if let missingFieldTest = try? decoder.decode(URLOptional.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Optional Null Omitting
    private struct URLOptionalNullOmitting: Codable {
        @BRCURLOptionalNullOmitting private(set) var testValue: URL?
    }
    
    func testOptionalNullOmitting() {
        if let validURLTest = try? decoder.decode(URLOptionalNullOmitting.self, from: URLTestData.validURLJSONData) {
            XCTAssert(validURLTest.testValue?.absoluteString == URLTestData.validURLString, "Valid URL decoded incorrectly")
            
            if let encoded = try? encoder.encode(validURLTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == URLTestData.validURLJSON, "Encoding valid URL produced bad JSON")
                
                if let decoded = try? decoder.decode(URLOptionalNullOmitting.self, from: encoded) {
                    XCTAssert(decoded.testValue?.absoluteString == URLTestData.validURLString, "Encoded valid URL decoded incorrectly")
                } else {
                    XCTFail("Encoded valid URL failed to decode")
                }
            } else {
                XCTFail("Valid URL failed to encode")
            }
        } else {
            XCTFail("Valid URL failed to decode")
        }
        
        if let invalidURLTest = try? decoder.decode(URLOptionalNullOmitting.self, from: URLTestData.invalidURLJSONData) {
            XCTAssert(invalidURLTest.testValue == nil, "Invalid URL decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidURLTest) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Encoding invalid URL produced bad JSON")
                
                if let decoded = try? decoder.decode(URLOptionalNullOmitting.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid URL decoded incorrectly")
                } else {
                    XCTFail("Encoded invalid URL failed to decode")
                }
            } else {
                XCTFail("Invalid URL failed to encode")
            }
        } else {
            XCTFail("Invalid URL failed to decode")
        }
        
        if let invalidTypeTest = try? decoder.decode(URLOptionalNullOmitting.self, from: URLTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTest.testValue == nil, "Invalid type decoded incorrectly")
        } else {
            XCTFail("Invalid type failed to decode")
        }
        
        if let nullLiteralTest = try? decoder.decode(URLOptionalNullOmitting.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTest.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Null literal failed to decode")
        }
        
        if let missingFieldTest = try? decoder.decode(URLOptionalNullOmitting.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTest.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Missing field failed to decode")
        }
    }
    
    // MARK: Required
    private struct URLRequired: Codable {
        @BRCURLRequired private(set) var testValue: URL
    }
    
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
}
