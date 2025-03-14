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
        
    // MARK: Optional ISO8601 Date
    private struct OptionalISO8601Date: Codable {
        @BRCDateISO8601Optional private(set) var testValue: Date?
    }
    
    func testOptionalISO8601Date() {
        if let wootenTestObject = try? decoder.decode(OptionalISO8601Date.self, from: DateTestData.wootenJSONData) {
            XCTAssert(wootenTestObject.testValue!.timeIntervalSince1970 == DateTestData.localizedWootenDate.timeIntervalSince1970, "Wooten epoch does not match")
            XCTAssert(wootenTestObject.testValue!.ISO8601Format() == DateTestData.localizedWootenDate.ISO8601Format(), "Wooten ISO8601 does not match")
            
            if let encoded = try? encoder.encode(wootenTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.wootenJSON, "Wooten encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == DateTestData.localizedWootenDate.timeIntervalSince1970, "Wooten E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == DateTestData.localizedWootenDate.ISO8601Format(), "Wooten E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded Wooten")
                }
            } else {
                XCTFail("Failed to encode Wooten")
            }
        } else {
            XCTFail("Failed to decode Wooten")
        }
        
        if let yesterdayTestObject = try? decoder.decode(OptionalISO8601Date.self, from: DateTestData.yesterdayJSONData) {
            XCTAssert(yesterdayTestObject.testValue!.timeIntervalSince1970 == DateTestData.yesterdayEpoch, "Yesterday epoch does not match")
            XCTAssert(yesterdayTestObject.testValue!.ISO8601Format() == DateTestData.yesterday.ISO8601Format(), "Yesterday ISO8601 does not match")
            if let encoded = try? encoder.encode(yesterdayTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.yesterdayJSON, "Yesterday encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == DateTestData.yesterdayEpoch, "Yesterday E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == DateTestData.yesterday.ISO8601Format(), "Yesterday E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded yesterday")
                }
            } else {
                XCTFail("Failed to encode yesterday")
            }
        } else {
            XCTFail("Failed to decode yesterday")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(OptionalISO8601Date.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
            if let encoded = try? encoder.encode(nullLiteralTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Null literal encoding produced bad JSON string")
                
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
        
        if let missingFieldTestObject = try? decoder.decode(OptionalISO8601Date.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
            if let encoded = try? encoder.encode(missingFieldTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Missing field encoding produced bad JSON string")
                
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
        
        if let invalidDateTestObject = try? decoder.decode(OptionalISO8601Date.self, from: DateTestData.invalidDateJSONData) {
            XCTAssert(invalidDateTestObject.testValue == nil, "Invalid date decoded incorrectly")
            if let encoded = try? encoder.encode(invalidDateTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Invalid date encoding produced bad JSON string")
                
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
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalISO8601Date.self, from: DateTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.nullLiteralJSON, "Invalid type encoding produced bad JSON string")
                
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
        if let wootenTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: DateTestData.wootenJSONData) {
            XCTAssert(wootenTestObject.testValue!.timeIntervalSince1970 == DateTestData.localizedWootenDate.timeIntervalSince1970, "Wooten epoch does not match")
            XCTAssert(wootenTestObject.testValue!.ISO8601Format() == DateTestData.localizedWootenDate.ISO8601Format(), "Wooten ISO8601 does not match")
            
            if let encoded = try? encoder.encode(wootenTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.wootenJSON, "Wooten encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == DateTestData.localizedWootenDate.timeIntervalSince1970, "Wooten E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == DateTestData.localizedWootenDate.ISO8601Format(), "Wooten E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded Wooten")
                }
            } else {
                XCTFail("Failed to encode Wooten")
            }
        } else {
            XCTFail("Failed to decode Wooten")
        }
        
        if let yesterdayTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: DateTestData.yesterdayJSONData) {
            XCTAssert(yesterdayTestObject.testValue!.timeIntervalSince1970 == DateTestData.yesterdayEpoch, "Yesterday epoch does not match")
            XCTAssert(yesterdayTestObject.testValue!.ISO8601Format() == DateTestData.yesterday.ISO8601Format(), "Yesterday ISO8601 does not match")
            if let encoded = try? encoder.encode(yesterdayTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.yesterdayJSON, "Yesterday encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue?.timeIntervalSince1970 == DateTestData.yesterdayEpoch, "Yesterday E/D epoch does not match")
                    XCTAssert(decoded.testValue?.ISO8601Format() == DateTestData.yesterday.ISO8601Format(), "Yesterday E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded yesterday")
                }
            } else {
                XCTFail("Failed to encode yesterday")
            }
        } else {
            XCTFail("Failed to decode yesterday")
        }
        
        if let nullLiteralTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null literal decoded incorrectly")
            if let encoded = try? encoder.encode(nullLiteralTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Null literal encoding produced bad JSON string")
                
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
        
        if let missingFieldTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing field decoded incorrectly")
            if let encoded = try? encoder.encode(missingFieldTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Missing field encoding produced bad JSON string")
                
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
        
        if let invalidDateTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: DateTestData.invalidDateJSONData) {
            XCTAssert(invalidDateTestObject.testValue == nil, "Invalid date decoded incorrectly")
            if let encoded = try? encoder.encode(invalidDateTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Invalid date encoding produced bad JSON string")
                
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
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalNullOmittingISO8601Date.self, from: DateTestData.invalidTypeJSONData) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Invalid type decoded incorrectly")
            if let encoded = try? encoder.encode(invalidTypeTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == GeneralTestData.missingFieldJSON, "Invalid type encoding produced bad JSON string")
                
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
        if let wootenTestObject = try? decoder.decode(RequiredISO8601Date.self, from: DateTestData.wootenJSONData) {
            XCTAssert(wootenTestObject.testValue.timeIntervalSince1970 == DateTestData.localizedWootenDate.timeIntervalSince1970, "Wooten epoch does not match")
            XCTAssert(wootenTestObject.testValue.ISO8601Format() == DateTestData.localizedWootenDate.ISO8601Format(), "Wooten ISO8601 does not match")
            
            if let encoded = try? encoder.encode(wootenTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.wootenJSON, "Wooten encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(RequiredISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue.timeIntervalSince1970 == DateTestData.localizedWootenDate.timeIntervalSince1970, "Wooten E/D epoch does not match")
                    XCTAssert(decoded.testValue.ISO8601Format() == DateTestData.localizedWootenDate.ISO8601Format(), "Wooten E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded Wooten")
                }
            } else {
                XCTFail("Failed to encode Wooten")
            }
        } else {
            XCTFail("Failed to decode Wooten")
        }
        
        if let yesterdayTestObject = try? decoder.decode(RequiredISO8601Date.self, from: DateTestData.yesterdayJSONData) {
            XCTAssert(yesterdayTestObject.testValue.timeIntervalSince1970 == DateTestData.yesterdayEpoch, "Yesterday epoch does not match")
            XCTAssert(yesterdayTestObject.testValue.ISO8601Format() == DateTestData.yesterday.ISO8601Format(), "Yesterday ISO8601 does not match")
            if let encoded = try? encoder.encode(yesterdayTestObject) {
                XCTAssert(String(data: encoded, encoding: .utf8)! == DateTestData.yesterdayJSON, "Yesterday encoding produced bad JSON string")
                
                if let decoded = try? decoder.decode(RequiredISO8601Date.self, from: encoded) {
                    XCTAssert(decoded.testValue.timeIntervalSince1970 == DateTestData.yesterdayEpoch, "Yesterday E/D epoch does not match")
                    XCTAssert(decoded.testValue.ISO8601Format() == DateTestData.yesterday.ISO8601Format(), "Yesterday E/D ISO8601 does not match")
                } else {
                    XCTFail("Failed to decode encoded yesterday")
                }
            } else {
                XCTFail("Failed to encode yesterday")
            }
        } else {
            XCTFail("Failed to decode yesterday")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTFail("Null literal decoded when it should not")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: GeneralTestData.missingFieldJSONData) {
            XCTFail("Missing field decoded when it should not")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: DateTestData.invalidDateJSONData) {
            XCTFail("Invalid date decoded when it should not")
        }
        
        if let _ = try? decoder.decode(RequiredISO8601Date.self, from: DateTestData.invalidTypeJSONData) {
            XCTFail("Invalid type decoded when it should not")
        }
    }
}

