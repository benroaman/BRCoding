import XCTest
@testable import BRCoding

final class BRCodingBoolTests: XCTestCase {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let trueLiteralJSON = #"{"testBool":true}"#.data(using: .utf8)!
    private let trueNumericalJSON = #"{"testBool":1}"#.data(using: .utf8)!
    private let trueStringyBoolJSON = #"{"testBool":"true"}"#.data(using: .utf8)!
    private let trueStringyIntJSON = #"{"testBool":"1"}"#.data(using: .utf8)!
    private let falseLiteralJSON = #"{"testBool":false}"#.data(using: .utf8)!
    private let falseNumericalJSON = #"{"testBool":0}"#.data(using: .utf8)!
    private let falseStringyBoolJSON = #"{"testBool":"false"}"#.data(using: .utf8)!
    private let falseStringyIntJSON = #"{"testBool":"0"}"#.data(using: .utf8)!
    private let nullLiteralJSON = #"{"testBool":null}"#.data(using: .utf8)!
    private let missingFieldJSON = #"{}"#.data(using: .utf8)!
    private let invalidStringJSON = #"{"testBool":"Sheboygan, WI"}"#.data(using: .utf8)!
    private let invalidIntJSON = #"{"testBool":19}"#.data(using: .utf8)!
    private let invalidTypeJSON = #"{"testBool":19.19}"#.data(using: .utf8)!
    
    // MARK: Default True Tests
    private struct DefaultTrue: Codable {
        @BRCBoolNonNullableDefaultTrue private(set) var testBool: Bool
    }
    
    func testDecodeDefaultTrueWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(DefaultTrue.self, from: trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testBool == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                
        if let trueNumericalTestObject = try? decoder.decode(DefaultTrue.self, from: trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testBool == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(DefaultTrue.self, from: trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testBool == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let truStringyIntTestObject = try? decoder.decode(DefaultTrue.self, from: trueStringyIntJSON) {
            XCTAssert(truStringyIntTestObject.testBool == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(DefaultTrue.self, from: falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testBool == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                
        if let falseNumericalTestObject = try? decoder.decode(DefaultTrue.self, from: falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testBool == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(DefaultTrue.self, from: falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testBool == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(DefaultTrue.self, from: falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testBool == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeDefaultTrueWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(DefaultTrue.self, from: nullLiteralJSON) {
            XCTAssert(nullLiteralTestObject.testBool == true, "Failed to apply default value for null literal")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(DefaultTrue.self, from: missingFieldJSON) {
            XCTAssert(missingFieldTestObject.testBool == true, "Failed to apply default value for missing field")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeDefaultTrueWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(DefaultTrue.self, from: invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testBool == true, "Failed to apply default value for invalid string")
        } else {
            XCTFail("Failed to decode with String Value")
        }
        
        if let invalidIntTestObject = try? decoder.decode(DefaultTrue.self, from: invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testBool == true, "Failed to apply default value for invalid int")
        } else {
            XCTFail("Failed to decode with Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(DefaultTrue.self, from: invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testBool == true, "Failed to apply default value for invalid type")
        } else {
            XCTFail("Failed to decode with Invalid Type")
        }
    }
    
    func testEncodeDefaultTrue() {
        let testObject = DefaultTrue(testBool: false)
        
        guard let encoded = try? encoder.encode(testObject) else { return XCTFail("Failed to encode DefaultTrue Object") }
        XCTAssert((String(data: encoded, encoding: .utf8) ?? "invalid json") == #"{"testBool":false}"#, "Encoding produced bad JSON String")
        
        guard let decoded = try? decoder.decode(DefaultTrue.self, from: encoded) else { return XCTFail("Failed to decode encoded Default True Object") }
        XCTAssert(decoded.testBool == false, "Default True Object Decoded Incorrectly")
    }
    
    // MARK: Default False Tests
    private struct DefaultFalse: Codable {
        @BRCBoolNonNullableDefaultFalse private(set) var testBool: Bool
    }
    
    func testDecodeDefaultFalseWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(DefaultFalse.self, from: trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testBool == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
           
        if let trueNumericalTestObject = try? decoder.decode(DefaultFalse.self, from: trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testBool == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(DefaultFalse.self, from: trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testBool == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let trueStringyIntTestObject = try? decoder.decode(DefaultFalse.self, from: trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testBool == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(DefaultFalse.self, from: falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testBool == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                
        if let falseNumericalTestObject = try? decoder.decode(DefaultFalse.self, from: falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testBool == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(DefaultFalse.self, from: falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testBool == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(DefaultFalse.self, from: falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testBool == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeDefaultFalseWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(DefaultFalse.self, from: nullLiteralJSON) {
            XCTAssert(nullLiteralTestObject.testBool == false, "Failed to apply default value for null literal")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(DefaultFalse.self, from: missingFieldJSON) {
            XCTAssert(missingFieldTestObject.testBool == false, "Failed to apply default value for missing field")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeDefaultFalseWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(DefaultFalse.self, from: invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testBool == false, "Failed to apply default value for invalid string")
        } else {
            XCTFail("Failed to decode Invalid String")
        }
                
        if let invalidIntTestObject = try? decoder.decode(DefaultFalse.self, from: invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testBool == false, "Failed to apply default value for invalid int")
        } else {
            XCTFail("Failed to decode Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(DefaultFalse.self, from: invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testBool == false, "Failed to apply default value for invalid type")
        } else {
            XCTFail("Failed to decode Invalid Type")
        }
    }
    
    func testEncodeDefaultFalse() {
        let testObject = DefaultFalse(testBool: true)
        
        guard let encoded = try? encoder.encode(testObject) else { return XCTAssert(false, "Failed to encode Default False Object") }
        XCTAssert((String(data: encoded, encoding: .utf8) ?? "invalid json") == #"{"testBool":true}"#, "Encoding produced bad JSON String")
        
        guard let decoded = try? decoder.decode(DefaultFalse.self, from: encoded) else { return XCTAssert(false, "Failed to decode encoded Default False Object") }
        XCTAssert(decoded.testBool == true, "Default False Object Decoded Incorrectly")
    }
    
    // MARK: Optional Bool Tests
    private struct OptionalBool: Codable {
        @BRCBoolOptional private(set) var testBool: Bool?
        
        init(testBool: Bool?) {
            self.testBool = testBool
        }
    }
    
    func testDecodeOptionalWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(OptionalBool.self, from: trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testBool == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                        
        if let trueNumericalTestObject = try? decoder.decode(OptionalBool.self, from: trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testBool == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
                
        if let trueStringyBoolTestObject = try? decoder.decode(OptionalBool.self, from: trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testBool == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
                
        if let trueStringyIntTestObject = try? decoder.decode(OptionalBool.self, from: trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testBool == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
                
        if let falseLiteralTestObject = try? decoder.decode(OptionalBool.self, from: falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testBool == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                        
        if let falseNumericalTestObject = try? decoder.decode(OptionalBool.self, from: falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testBool == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
                
        if let falseStringyBoolTestObject = try? decoder.decode(OptionalBool.self, from: falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testBool == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
                
        if let falseStringyIntTestObject = try? decoder.decode(OptionalBool.self, from: falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testBool == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeOptionalWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(OptionalBool.self, from: nullLiteralJSON) {
            XCTAssert(nullLiteralTestObject.testBool == nil, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalBool.self, from: missingFieldJSON) {
            XCTAssert(missingFieldTestObject.testBool == nil, "Missing Field decoded incorrectly")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeOptionalWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(OptionalBool.self, from: invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testBool == nil, "String Value decoded incorrectly")
        } else {
            XCTFail("Failed to decode String Value")
        }
                
        if let invalidIntTestObject = try? decoder.decode(OptionalBool.self, from: invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testBool == nil, "Invalid Int decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(OptionalBool.self, from: invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testBool == nil, "Double Value decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Double Value")
        }
    }
    
    func testEncodeOptional() {
        // True
        let testObjectTrue = OptionalBool(testBool: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTFail("Failed to encode Optional Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testBool":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(OptionalBool.self, from: encodedTrue) else { return XCTFail("Failed to decode encoded Optional Bool Object") }
        XCTAssert(decodedTrue.testBool == true, "Optional Bool Object Decoded Incorrectly")
        
        // Nil
        let testObjectNil = OptionalBool(testBool: nil)
        
        guard let encodedNil = try? encoder.encode(testObjectNil) else { return XCTFail("Failed to encode Optional Bool Object") }
        XCTAssert((String(data: encodedNil, encoding: .utf8) ?? "invalid json") == #"{"testBool":null}"#, "Encoding produced bad JSON String")
        
        guard let decodedNil = try? decoder.decode(OptionalBool.self, from: encodedNil) else { return XCTFail("Failed to decode encoded Optional Bool Object") }
        XCTAssert(decodedNil.testBool == nil, "Optional Bool Object Decoded Incorrectly")
    }
    
    // MARK: Required Bool Tests
    private struct RequiredBool: Codable {
        @BRCBoolRequired private(set) var testBool: Bool
    }
    
    func testDecodeRequiredWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(RequiredBool.self, from: trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testBool == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                        
        if let trueNumericalTestObject = try? decoder.decode(RequiredBool.self, from: trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testBool == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
                
        if let trueStringyBoolTestObject = try? decoder.decode(RequiredBool.self, from: trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testBool == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
                
        if let trueStringyIntTestObject = try? decoder.decode(RequiredBool.self, from: trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testBool == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
                
        if let falseLiteralTestObject = try? decoder.decode(RequiredBool.self, from: falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testBool == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                        
        if let falseNumericalTestObject = try? decoder.decode(RequiredBool.self, from: falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testBool == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
                
        if let falseStringyBoolTestObject = try? decoder.decode(RequiredBool.self, from: falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testBool == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
                
        if let falseStringyIntTestObject = try? decoder.decode(RequiredBool.self, from: falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testBool == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeRequiredWithValueAbsent() {
        // Null Literal
        let nullLiteralTestObject = try? decoder.decode(RequiredBool.self, from: nullLiteralJSON)
        XCTAssert(nullLiteralTestObject == nil, "Null Literal should cause decode failure")
        
        // Missing Field
        let missingFieldTestObject = try? decoder.decode(RequiredBool.self, from: missingFieldJSON)
        XCTAssert(missingFieldTestObject == nil, "Missing Field should cause decode failure")
    }
    
    func testDecodeRequiredWithInvalidValue() {
        // Invalid String
        let invalidStringTestObject = try? decoder.decode(RequiredBool.self, from: invalidStringJSON)
        XCTAssert(invalidStringTestObject == nil, "Invalid String should cause decode failure")
        
        // Invalid Int
        let invalidIntTestObject = try? decoder.decode(RequiredBool.self, from: invalidIntJSON)
        XCTAssert(invalidIntTestObject == nil, "Invalid Int should cause decode failure")
        
        // Invalid Type
        let invalidTypeTestObject = try? decoder.decode(RequiredBool.self, from: invalidTypeJSON)
        XCTAssert(invalidTypeTestObject == nil, "Non-Int, Non-String, Non-Bool value should cause decode failure")
    }
    
    func testEncodeRequired() {
        // True
        let testObjectTrue = RequiredBool(testBool: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTAssert(false, "Failed to encode Required Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testBool":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(RequiredBool.self, from: encodedTrue) else { return XCTAssert(false, "Failed to decode encoded Required Bool Object") }
        XCTAssert(decodedTrue.testBool == true, "Required Bool Object Decoded Incorrectly")
        
        // False
        let testObjectFalse = RequiredBool(testBool: false)
        
        guard let encodedFalse = try? encoder.encode(testObjectFalse) else { return XCTAssert(false, "Failed to encode Required Bool Object") }
        XCTAssert((String(data: encodedFalse, encoding: .utf8) ?? "invalid json") == #"{"testBool":false}"#, "Encoding produced bad JSON String")
        
        guard let decodedFalse = try? decoder.decode(RequiredBool.self, from: encodedFalse) else { return XCTAssert(false, "Failed to decode encoded Required Bool Object") }
        XCTAssert(decodedFalse.testBool == false, "Required Bool Object Decoded Incorrectly")
    }
    
    // MARK: Optional Null Omitting
    private struct OptionalNullOmittingBool: Codable {
        @BRCBoolOptionalNullOmitting private(set) var testBool: Bool?
        init(testBool: Bool?) { self.testBool = testBool }
    }
    
    func testDecodeOptionalNullOmittingWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testBool == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
        
        if let trueNumericalTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testBool == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testBool == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let trueStringyIntTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testBool == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testBool == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
        
        if let falseNumericalTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testBool == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testBool == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testBool == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeOptionalNullOmittingWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: nullLiteralJSON) {
            XCTAssert(nullLiteralTestObject.testBool == nil, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: missingFieldJSON) {
            XCTAssert(missingFieldTestObject.testBool == nil, "Missing Field decoded incorrectly")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeOptionalNullOmittingWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testBool == nil, "String Value decoded incorrectly")
        } else {
            XCTFail("Failed to decode String Value")
        }
        
        if let invalidIntTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testBool == nil, "Invalid Int decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Invalid Int")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testBool == nil, "Double Value decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Double Value")
        }
    }
    
    func testEncodeOptionalNullOmitting() {
        // True
        let testObjectTrue = OptionalNullOmittingBool(testBool: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTFail("Failed to encode Optional Null Omitting Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testBool":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(OptionalBool.self, from: encodedTrue) else { return XCTFail("Failed to decode encoded Optional Null Omitting Bool Object") }
        XCTAssert(decodedTrue.testBool == true, "Optional Null Omitting Bool Object Decoded Incorrectly")
        
        // Nil
        let testObjectNil = OptionalNullOmittingBool(testBool: nil)
        
        guard let encodedNil = try? encoder.encode(testObjectNil) else { return XCTFail("Failed to encode Optional Null Omitting Bool Object") }
        let jsonStr = String(data: encodedNil, encoding: .utf8) ?? "invalid json"
        XCTAssert(jsonStr == #"{}"#, "Encoding produced bad JSON String :: \(jsonStr)")
        
        guard let decodedNil = try? decoder.decode(OptionalBool.self, from: encodedNil) else { return XCTFail("Failed to decode encoded Optional Null Omitting Bool Object") }
        XCTAssert(decodedNil.testBool == nil, "Optional Null Omitting Bool Object Decoded Incorrectly")
    }
}

