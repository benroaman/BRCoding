//
//  BRCDateTests.swift
//
//
//  Created by Ben Roaman on 3/11/25.
//

import XCTest
@testable import BRCoding

final class BRCStringTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Data
    let validString = "This is a valid string, y'all 🥸"
    private lazy var validStringJSON = #"{"testValue":"\#(validString)"}"#
    private lazy var validStringJSONData = validStringJSON.data(using: .utf8)!
    
    let emptyString = ""
    private lazy var emptyStringJSON = #"{"testValue":"\#(emptyString)"}"#
    private lazy var emptyStringJSONData = emptyStringJSON.data(using: .utf8)!
    
    let whitespaceString = "  \n "
    private lazy var whitespaceStringJSONData = (try? encoder.encode(["testValue": whitespaceString]))!
    private lazy var whitespaceStringJSON = String(data: whitespaceStringJSONData, encoding: .utf8)!
    
    private let invalidTypeJSON = #"{"testValue": 12345}"#
    private lazy var invalidTypeJSONData = invalidTypeJSON.data(using: .utf8)!
    
    // MARK: Optional
    private struct StringOptional: Codable {
        @BRCStringOptional private(set) var testValue: String?
    }
    
    func testOptional() {
        if let validStringTestObject = try? decoder.decode(StringOptional.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringOptional.self, from: encoded) {
                    XCTAssert(decoded.testValue == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(StringOptional.self, from: emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == emptyString, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringOptional.self, from: whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == whitespaceString, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(StringOptional.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(StringOptional.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(StringOptional.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.nullLiteralJSON, "Encoding invalid type produced bad JSON")
                if let decoded = try? decoder.decode(StringOptional.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid type decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid type")
                }
            } else {
                XCTFail("Failed to encode invalid type")
            }
        } else {
            XCTFail("Failed to decode invalid type")
        }
    }
    
    // MARK: Optional Null Omitting
    private struct StringOptionalNullOmitting: Codable {
        @BRCStringOptionalNullOmitting private(set) var testValue: String?
    }
    
    func testOptionalNullOmitting() {
        if let validStringTestObject = try? decoder.decode(StringOptionalNullOmitting.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalNullOmitting.self, from: encoded) {
                    XCTAssert(decoded.testValue == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(StringOptionalNullOmitting.self, from: emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == emptyString, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringOptionalNullOmitting.self, from: whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == whitespaceString, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(StringOptionalNullOmitting.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(StringOptionalNullOmitting.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(StringOptionalNullOmitting.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.missingFieldJSON, "Encoding invalid type produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalNullOmitting.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid type decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid type")
                }
            } else {
                XCTFail("Failed to encode invalid type")
            }
        } else {
            XCTFail("Failed to decode invalid type")
        }
    }
    
    // MARK: Optional Strict
    private struct StringOptionalStrict: Codable {
        @BRCStringOptionalStrict private(set) var testValue: String?
    }
    
    func testOptionalStrict() {
        if let validStringTestObject = try? decoder.decode(StringOptionalStrict.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalStrict.self, from: encoded) {
                    XCTAssert(decoded.testValue == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(StringOptionalStrict.self, from: emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == nil, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringOptionalStrict.self, from: whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == nil, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(StringOptionalStrict.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(StringOptionalStrict.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(StringOptionalStrict.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.nullLiteralJSON, "Encoding invalid type produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalStrict.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid type decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid type")
                }
            } else {
                XCTFail("Failed to encode invalid type")
            }
        } else {
            XCTFail("Failed to decode invalid type")
        }
    }
    
    // MARK: Optional Strict Null Omitting
    private struct StringOptionalStrictNullOmitting: Codable {
        @BRCStringOptionalStrictNullOmitting private(set) var testValue: String?
    }
    
    func testOptionalStrictNullOmitting() {
        if let validStringTestObject = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: encoded) {
                    XCTAssert(decoded.testValue == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == nil, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == nil, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.missingFieldJSON, "Encoding invalid type produced bad JSON")
                if let decoded = try? decoder.decode(StringOptionalStrictNullOmitting.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid type decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid type")
                }
            } else {
                XCTFail("Failed to encode invalid type")
            }
        } else {
            XCTFail("Failed to decode invalid type")
        }
    }
    
    // MARK: Required
    private struct StringRequired: Codable {
        @BRCStringRequired private(set) var testValue: String
    }
    
    func testRequired() {
        if let validStringTestObject = try? decoder.decode(StringRequired.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringRequired.self, from: encoded) {
                    XCTAssert(decoded.testValue == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let emptyStringTestObject = try? decoder.decode(StringRequired.self, from: emptyStringJSONData) {
            XCTAssert(emptyStringTestObject.testValue == emptyString, "Empty string decoded incorrectly")
        } else {
            XCTFail("Failed to decode empty string")
        }
        
        if let whitespaceStringTestObject = try? decoder.decode(StringRequired.self, from: whitespaceStringJSONData) {
            XCTAssert(whitespaceStringTestObject.testValue == whitespaceString, "Whitespace string decoded Incorrectly")
        } else {
            XCTFail("Failed to decode whitespace string")
        }
        
        if let _ = try? decoder.decode(StringRequired.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTFail("Decoded null literal, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequired.self, from: BRCodingTests.missingFieldJSONData) {
            XCTFail("Decoded missing field, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequired.self, from: invalidTypeJSONData) {
            XCTFail("Decoded invalid type, should have failed")
        }
    }
    
    // MARK: Required Strict
    private struct StringRequiredStrict: Codable {
        @BRCStringRequiredStrict private(set) var testValue: String
    }
    
    func testRequiredStrict() {
        if let validStringTestObject = try? decoder.decode(StringRequiredStrict.self, from: validStringJSONData) {
            XCTAssert(validStringTestObject.testValue == validString, "Valid string decoded incorrectly")
            
            if let encoded = try? encoder.encode(validStringTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == validStringJSON, "Encoding valid string produced bad JSON")
                if let decoded = try? decoder.decode(StringRequired.self, from: encoded) {
                    XCTAssert(decoded.testValue == validString, "Encoded valid string decoded incorrectly")
                } else {
                    XCTFail("Encoded valid string failed to decode")
                }
            } else {
                XCTFail("Valid string failed to encode")
            }
        } else {
            XCTFail("Failed to decode valid string")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: emptyStringJSONData) {
            XCTFail("Decoded empty string, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: whitespaceStringJSONData) {
            XCTFail("Decoded whitespace string, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTFail("Decoded null literal, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: BRCodingTests.missingFieldJSONData) {
            XCTFail("Decoded missing field, should have failed")
        }
        
        if let _ = try? decoder.decode(StringRequiredStrict.self, from: invalidTypeJSONData) {
            XCTFail("Decoded invalid type, should have failed")
        }
    }
}
