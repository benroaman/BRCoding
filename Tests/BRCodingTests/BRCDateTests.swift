//
//  BRCDateTests.swift
//
//
//  Created by Ben Roaman on 3/11/25.
//

import XCTest
@testable import BRCoding

final class BRCDateTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Test Data
    private let wootenISO6601 = "1964-09-11T19:15:00-01:00"
    private var wootenJSON: String { #"{"testValue":"\#(wootenISO6601)"}"# }
    private var wootenJSONData: Data { wootenJSON.data(using: .utf8)! }
    private lazy var localizedWootenDate: Date = { (try? Date(wootenISO6601, strategy: .iso8601))! }()
    private let yesterday = Date().addingTimeInterval(-24*60*60)
    private lazy var yesterdayEpoch: TimeInterval = { yesterday.timeIntervalSince1970.rounded(.towardZero) }()
    private var yesterdayJSON: String { #"{"testValue":"\#(yesterday.ISO8601Format())"}"# }
    private var yesterdayJSONData: Data { yesterdayJSON.data(using: .utf8)! }
    private let invalidDateJSON = #"{"testValue":"2025-03-03"}"#
    private var invalidDateJSONData: Data { invalidDateJSON.data(using: .utf8)! }
    private let invalidTypeJSON = #"{"testValue":12345}"#
    private var invalidTypeJSONData: Data { invalidTypeJSON.data(using: .utf8)! }
    
    // MARK: Optional ISO8601 Date
    private struct OptionalISO8601Date: Codable {
        @BRCDateISO8601Optional private(set) var testValue: Date?
    }
    
    func testOptionalISO8601Date() {
        if let wootenTestObject = try? decoder.decode(OptionalISO8601Date.self, from: wootenJSONData) {
            XCTAssert(wootenTestObject.testValue!.timeIntervalSince1970 == localizedWootenDate.timeIntervalSince1970, "Wooten epoch does not match")
            XCTAssert(wootenTestObject.testValue!.ISO8601Format() == localizedWootenDate.ISO8601Format(), "Wooten ISO8601 does not match")
            
            if let encoded = try? encoder.encode(wootenTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == wootenJSON, "Wooten encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == localizedWootenDate.timeIntervalSince1970, "Wooten E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == localizedWootenDate.ISO8601Format(), "Wooten E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded Wooten")
                }
            } else {
                XCTFail("Failed to encode Wooten")
            }
        } else {
            XCTFail("Failed to decode Wooten")
        }
        
        if let yesterdayTestObject = try? decoder.decode(OptionalISO8601Date.self, from: yesterdayJSONData) {
            XCTAssert(yesterdayTestObject.testValue!.timeIntervalSince1970 == yesterdayEpoch, "Yesterday epoch does not match")
            XCTAssert(yesterdayTestObject.testValue!.ISO8601Format() == yesterday.ISO8601Format(), "Yesterday ISO8601 does not match")
            if let encoded = try? encoder.encode(yesterdayTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == yesterdayJSON, "Yesterday encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == yesterdayEpoch, "Yesterday E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == yesterday.ISO8601Format(), "Yesterday E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded yesterday")
                }
            } else {
                XCTFail("Failed to encode yesterday")
            }
        } else {
            XCTFail("Failed to decode yesterday")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(OptionalISO8601Date.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
            if let encoded = try? encoder.encode(nullLiteralTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.nullLiteralJSON, "Null literal encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded null literal decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded null literal")
                }
            } else {
                XCTFail("Failed to encode null literal")
            }
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalISO8601Date.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
            if let encoded = try? encoder.encode(missingFieldTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.nullLiteralJSON, "Missing field encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded missing field decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded missing field")
                }
            } else {
                XCTFail("Failed to encode missing field")
            }
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidDateTestObject = try? decoder.decode(OptionalISO8601Date.self, from: invalidDateJSONData) {
            XCTAssert(invalidDateTestObject.testValue == nil, "Invalid date decoded incorrectly")
            if let encoded = try? encoder.encode(invalidDateTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.nullLiteralJSON, "Invalid date encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid date decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid date")
                }
            } else {
                XCTFail("Failed to encode invalid date")
            }
        } else {
            XCTFail("Failed to decode invalid date")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalISO8601Date.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.nullLiteralJSON, "Invalid type encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
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
    
    // MARK: Optional Null Omitting ISO8601 Date
    private struct OptionalNullOmittingISO8601Date: Codable {
        @BRCDateISO8601OptionalNullOmitting private(set) var testValue: Date?
    }
    
    func testOptionalNullOmittingISO8601Date() {
        if let wootenTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: wootenJSONData) {
            XCTAssert(wootenTestObject.testValue!.timeIntervalSince1970 == localizedWootenDate.timeIntervalSince1970, "Wooten epoch does not match")
            XCTAssert(wootenTestObject.testValue!.ISO8601Format() == localizedWootenDate.ISO8601Format(), "Wooten ISO8601 does not match")
            
            if let encoded = try? encoder.encode(wootenTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == wootenJSON, "Wooten encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == localizedWootenDate.timeIntervalSince1970, "Wooten E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == localizedWootenDate.ISO8601Format(), "Wooten E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded Wooten")
                }
            } else {
                XCTFail("Failed to encode Wooten")
            }
        } else {
            XCTFail("Failed to decode Wooten")
        }
        
        if let yesterdayTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: yesterdayJSONData) {
            XCTAssert(yesterdayTestObject.testValue!.timeIntervalSince1970 == yesterdayEpoch, "Yesterday epoch does not match")
            XCTAssert(yesterdayTestObject.testValue!.ISO8601Format() == yesterday.ISO8601Format(), "Yesterday ISO8601 does not match")
            if let encoded = try? encoder.encode(yesterdayTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == yesterdayJSON, "Yesterday encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == yesterdayEpoch, "Yesterday E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == yesterday.ISO8601Format(), "Yesterday E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded yesterday")
                }
            } else {
                XCTFail("Failed to encode yesterday")
            }
        } else {
            XCTFail("Failed to decode yesterday")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
            if let encoded = try? encoder.encode(nullLiteralTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.missingFieldJSON, "Null literal encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded null literal decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded null literal")
                }
            } else {
                XCTFail("Failed to encode null literal")
            }
        } else {
            XCTFail("Failed to decode null literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: BRCodingTests.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
            if let encoded = try? encoder.encode(missingFieldTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.missingFieldJSON, "Missing field encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded missing field decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded missing field")
                }
            } else {
                XCTFail("Failed to encode missing field")
            }
        } else {
            XCTFail("Failed to decode missing field")
        }
        
        if let invalidDateTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: invalidDateJSONData) {
            XCTAssert(invalidDateTestObject.testValue == nil, "Invalid date decoded incorrectly")
            if let encoded = try? encoder.encode(invalidDateTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.missingFieldJSON, "Invalid date encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue == nil, "Encoded invalid date decoded incorrectly")
                } else {
                    XCTFail("Failed to decode encoded invalid date")
                }
            } else {
                XCTFail("Failed to encode invalid date")
            }
        } else {
            XCTFail("Failed to decode invalid date")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == BRCodingTests.missingFieldJSON, "Invalid type encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
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
    
    // MARK: Required ISO8601 Date
    private struct RequiredISO8601Date: Codable {
        @BRCDateISO8601Required private(set) var testValue: Date
    }
    
    func testRequiredISO8601Date() {
        if let wootenTestObject = try? decoder.decode(RequiredISO8601Date.self, from: wootenJSONData) {
            XCTAssert(wootenTestObject.testValue.timeIntervalSince1970 == localizedWootenDate.timeIntervalSince1970, "Wooten epoch does not match")
            XCTAssert(wootenTestObject.testValue.ISO8601Format() == localizedWootenDate.ISO8601Format(), "Wooten ISO8601 does not match")
            
            if let encoded = try? encoder.encode(wootenTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == wootenJSON, "Wooten encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(RequiredISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue.timeIntervalSince1970 == localizedWootenDate.timeIntervalSince1970, "Wooten E/D epoch does not match")
                    XCTAssert(decoded.testValue.ISO8601Format() == localizedWootenDate.ISO8601Format(), "Wooten E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded Wooten")
                }
            } else {
                XCTFail("Failed to encode Wooten")
            }
        } else {
            XCTFail("Failed to decode Wooten")
        }
        
        if let yesterdayTestObject = try? decoder.decode(RequiredISO8601Date.self, from: yesterdayJSONData) {
            XCTAssert(yesterdayTestObject.testValue.timeIntervalSince1970 == yesterdayEpoch, "Yesterday epoch does not match")
            XCTAssert(yesterdayTestObject.testValue.ISO8601Format() == yesterday.ISO8601Format(), "Yesterday ISO8601 does not match")
            if let encoded = try? encoder.encode(yesterdayTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == yesterdayJSON, "Yesterday encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(RequiredISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue.timeIntervalSince1970 == yesterdayEpoch, "Yesterday E/D epoch does not match")
                    XCTAssert(decoded.testValue.ISO8601Format() == yesterday.ISO8601Format(), "Yesterday E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded yesterday")
                }
            } else {
                XCTFail("Failed to encode yesterday")
            }
        } else {
            XCTFail("Failed to decode yesterday")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: BRCodingTests.nullLiteralJSONData) {
            XCTFail("Null literal decoded when it should not")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: BRCodingTests.missingFieldJSONData) {
            XCTFail("Missing field decoded when it should not")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: invalidDateJSONData) {
            XCTFail("Invalid date decoded when it should not")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: invalidTypeJSONData) {
            XCTFail("Invalid type decoded when it should not")
        }
    }
}

