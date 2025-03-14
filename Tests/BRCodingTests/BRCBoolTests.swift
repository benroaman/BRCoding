import XCTest
@testable import BRCoding

final class BRCBoolTests: XCTestCase {
    // MARK: Coders
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: Default True Tests
    private struct DefaultTrue: Codable {
        @BRCBoolNonNullableDefaultTrue private(set) var testValue: Bool
    }
    
    func testDecodeDefaultTrueWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                
        if let trueNumericalTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let truStringyIntTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssert(truStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                
        if let falseNumericalTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeDefaultTrueWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(DefaultTrue.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == true, "Failed to apply default value for null literal")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(DefaultTrue.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == true, "Failed to apply default value for missing field")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeDefaultTrueWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testValue == true, "Failed to apply default value for invalid string")
        } else {
            XCTFail("Failed to decode with String Value")
        }
        
        if let invalidIntTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testValue == true, "Failed to apply default value for invalid int")
        } else {
            XCTFail("Failed to decode with Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(DefaultTrue.self, from: BoolTestData.invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testValue == true, "Failed to apply default value for invalid type")
        } else {
            XCTFail("Failed to decode with Invalid Type")
        }
    }
    
    func testEncodeDefaultTrue() {
        let testObject = DefaultTrue(testValue: false)
        
        guard let encoded = try? encoder.encode(testObject) else { return XCTFail("Failed to encode DefaultTrue Object") }
        XCTAssert(String(data: encoded, encoding: .utf8) == #"{"testValue":false}"#, "Encoding produced bad JSON String")
        
        guard let decoded = try? decoder.decode(DefaultTrue.self, from: encoded) else { return XCTFail("Failed to decode encoded Default True Object") }
        XCTAssert(decoded.testValue == false, "Default True Object Decoded Incorrectly")
    }
    
    // MARK: Default False Tests
    private struct DefaultFalse: Codable {
        @BRCBoolNonNullableDefaultFalse private(set) var testValue: Bool
    }
    
    func testDecodeDefaultFalseWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
           
        if let trueNumericalTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let trueStringyIntTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                
        if let falseNumericalTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeDefaultFalseWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(DefaultFalse.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == false, "Failed to apply default value for null literal")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(DefaultFalse.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == false, "Failed to apply default value for missing field")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeDefaultFalseWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testValue == false, "Failed to apply default value for invalid string")
        } else {
            XCTFail("Failed to decode Invalid String")
        }
                
        if let invalidIntTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testValue == false, "Failed to apply default value for invalid int")
        } else {
            XCTFail("Failed to decode Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(DefaultFalse.self, from: BoolTestData.invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testValue == false, "Failed to apply default value for invalid type")
        } else {
            XCTFail("Failed to decode Invalid Type")
        }
    }
    
    func testEncodeDefaultFalse() {
        let testObject = DefaultFalse(testValue: true)
        
        guard let encoded = try? encoder.encode(testObject) else { return XCTAssert(false, "Failed to encode Default False Object") }
        XCTAssert((String(data: encoded, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decoded = try? decoder.decode(DefaultFalse.self, from: encoded) else { return XCTAssert(false, "Failed to decode encoded Default False Object") }
        XCTAssert(decoded.testValue == true, "Default False Object Decoded Incorrectly")
    }
    
    // MARK: Optional Bool Tests
    private struct OptionalBool: Codable {
        @BRCBoolOptional private(set) var testValue: Bool?
        
        init(testValue: Bool?) {
            self.testValue = testValue
        }
    }
    
    func testDecodeOptionalWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                        
        if let trueNumericalTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
                
        if let trueStringyBoolTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
                
        if let trueStringyIntTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
                
        if let falseLiteralTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                        
        if let falseNumericalTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
                
        if let falseStringyBoolTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
                
        if let falseStringyIntTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeOptionalWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(OptionalBool.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalBool.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing Field decoded incorrectly")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeOptionalWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testValue == nil, "String Value decoded incorrectly")
        } else {
            XCTFail("Failed to decode String Value")
        }
                
        if let invalidIntTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testValue == nil, "Invalid Int decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Invalid Int")
        }
                
        if let invalidTypeTestObject = try? decoder.decode(OptionalBool.self, from: BoolTestData.invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Double Value decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Double Value")
        }
    }
    
    func testEncodeOptional() {
        // True
        let testObjectTrue = OptionalBool(testValue: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTFail("Failed to encode Optional Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(OptionalBool.self, from: encodedTrue) else { return XCTFail("Failed to decode encoded Optional Bool Object") }
        XCTAssert(decodedTrue.testValue == true, "Optional Bool Object Decoded Incorrectly")
        
        // Nil
        let testObjectNil = OptionalBool(testValue: nil)
        
        guard let encodedNil = try? encoder.encode(testObjectNil) else { return XCTFail("Failed to encode Optional Bool Object") }
        XCTAssert((String(data: encodedNil, encoding: .utf8) ?? "invalid json") == #"{"testValue":null}"#, "Encoding produced bad JSON String")
        
        guard let decodedNil = try? decoder.decode(OptionalBool.self, from: encodedNil) else { return XCTFail("Failed to decode encoded Optional Bool Object") }
        XCTAssert(decodedNil.testValue == nil, "Optional Bool Object Decoded Incorrectly")
    }
    
    // MARK: Required Bool Tests
    private struct RequiredBool: Codable {
        @BRCBoolRequired private(set) var testValue: Bool
    }
    
    func testDecodeRequiredWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
                        
        if let trueNumericalTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
                
        if let trueStringyBoolTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
                
        if let trueStringyIntTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
                
        if let falseLiteralTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
                        
        if let falseNumericalTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
                
        if let falseStringyBoolTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
                
        if let falseStringyIntTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeRequiredWithValueAbsent() {
        // Null Literal
        let nullLiteralTestObject = try? decoder.decode(RequiredBool.self, from: GeneralTestData.nullLiteralJSONData)
        XCTAssert(nullLiteralTestObject == nil, "Null Literal should cause decode failure")
        
        // Missing Field
        let missingFieldTestObject = try? decoder.decode(RequiredBool.self, from: GeneralTestData.missingFieldJSONData)
        XCTAssert(missingFieldTestObject == nil, "Missing Field should cause decode failure")
    }
    
    func testDecodeRequiredWithInvalidValue() {
        // Invalid String
        let invalidStringTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.invalidStringJSON)
        XCTAssert(invalidStringTestObject == nil, "Invalid String should cause decode failure")
        
        // Invalid Int
        let invalidIntTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.invalidIntJSON)
        XCTAssert(invalidIntTestObject == nil, "Invalid Int should cause decode failure")
        
        // Invalid Type
        let invalidTypeTestObject = try? decoder.decode(RequiredBool.self, from: BoolTestData.invalidTypeJSON)
        XCTAssert(invalidTypeTestObject == nil, "Non-Int, Non-String, Non-Bool value should cause decode failure")
    }
    
    func testEncodeRequired() {
        // True
        let testObjectTrue = RequiredBool(testValue: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTAssert(false, "Failed to encode Required Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(RequiredBool.self, from: encodedTrue) else { return XCTAssert(false, "Failed to decode encoded Required Bool Object") }
        XCTAssert(decodedTrue.testValue == true, "Required Bool Object Decoded Incorrectly")
        
        // False
        let testObjectFalse = RequiredBool(testValue: false)
        
        guard let encodedFalse = try? encoder.encode(testObjectFalse) else { return XCTAssert(false, "Failed to encode Required Bool Object") }
        XCTAssert((String(data: encodedFalse, encoding: .utf8) ?? "invalid json") == #"{"testValue":false}"#, "Encoding produced bad JSON String")
        
        guard let decodedFalse = try? decoder.decode(RequiredBool.self, from: encodedFalse) else { return XCTAssert(false, "Failed to decode encoded Required Bool Object") }
        XCTAssert(decodedFalse.testValue == false, "Required Bool Object Decoded Incorrectly")
    }
    
    // MARK: Optional Null Omitting
    private struct OptionalNullOmittingBool: Codable {
        @BRCBoolOptionalNullOmitting private(set) var testValue: Bool?
        init(testValue: Bool?) { self.testValue = testValue }
    }
    
    func testDecodeOptionalNullOmittingWithValuePresent() throws {
        if let trueLiteralTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.trueLiteralJSON) {
            XCTAssert(trueLiteralTestObject.testValue == true, "True Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Literal")
        }
        
        if let trueNumericalTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.trueNumericalJSON) {
            XCTAssert(trueNumericalTestObject.testValue == true, "True Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Numerical")
        }
        
        if let trueStringyBoolTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.trueStringyBoolJSON) {
            XCTAssert(trueStringyBoolTestObject.testValue == true, "True Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Bool")
        }
        
        if let trueStringyIntTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.trueStringyIntJSON) {
            XCTAssert(trueStringyIntTestObject.testValue == true, "True Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode True Stringy Int")
        }
        
        if let falseLiteralTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.falseLiteralJSON) {
            XCTAssert(falseLiteralTestObject.testValue == false, "False Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Literal")
        }
        
        if let falseNumericalTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.falseNumericalJSON) {
            XCTAssert(falseNumericalTestObject.testValue == false, "False Numerical decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Numerical")
        }
        
        if let falseStringyBoolTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.falseStringyBoolJSON) {
            XCTAssert(falseStringyBoolTestObject.testValue == false, "False Stringy Bool decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Bool")
        }
        
        if let falseStringyIntTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.falseStringyIntJSON) {
            XCTAssert(falseStringyIntTestObject.testValue == false, "False Stringy Int decoded incorrectly")
        } else {
            XCTFail("Failed to decode False Stringy Int")
        }
    }
    
    func testDecodeOptionalNullOmittingWithValueAbsent() {
        if let nullLiteralTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: GeneralTestData.nullLiteralJSONData) {
            XCTAssert(nullLiteralTestObject.testValue == nil, "Null Literal decoded incorrectly")
        } else {
            XCTFail("Failed to decode Null Literal")
        }
        
        if let missingFieldTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: GeneralTestData.missingFieldJSONData) {
            XCTAssert(missingFieldTestObject.testValue == nil, "Missing Field decoded incorrectly")
        } else {
            XCTFail("Failed to decode Missing Field")
        }
    }
    
    func testDecodeOptionalNullOmittingWithInvalidValue() {
        if let invalidStringTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.invalidStringJSON) {
            XCTAssert(invalidStringTestObject.testValue == nil, "String Value decoded incorrectly")
        } else {
            XCTFail("Failed to decode String Value")
        }
        
        if let invalidIntTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.invalidIntJSON) {
            XCTAssert(invalidIntTestObject.testValue == nil, "Invalid Int decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Invalid Int")
        }
        
        if let invalidTypeTestObject = try? decoder.decode(OptionalNullOmittingBool.self, from: BoolTestData.invalidTypeJSON) {
            XCTAssert(invalidTypeTestObject.testValue == nil, "Double Value decoded incorrectly")
        } else {
            XCTAssert(false, "Failed to decode Double Value")
        }
    }
    
    func testEncodeOptionalNullOmitting() {
        // True
        let testObjectTrue = OptionalNullOmittingBool(testValue: true)
        
        guard let encodedTrue = try? encoder.encode(testObjectTrue) else { return XCTFail("Failed to encode Optional Null Omitting Bool Object") }
        XCTAssert((String(data: encodedTrue, encoding: .utf8) ?? "invalid json") == #"{"testValue":true}"#, "Encoding produced bad JSON String")
        
        guard let decodedTrue = try? decoder.decode(OptionalBool.self, from: encodedTrue) else { return XCTFail("Failed to decode encoded Optional Null Omitting Bool Object") }
        XCTAssert(decodedTrue.testValue == true, "Optional Null Omitting Bool Object Decoded Incorrectly")
        
        // Nil
        let testObjectNil = OptionalNullOmittingBool(testValue: nil)
        
        guard let encodedNil = try? encoder.encode(testObjectNil) else { return XCTFail("Failed to encode Optional Null Omitting Bool Object") }
        let jsonStr = String(data: encodedNil, encoding: .utf8) ?? "invalid json"
        XCTAssert(jsonStr == #"{}"#, "Encoding produced bad JSON String :: \(jsonStr)")
        
        guard let decodedNil = try? decoder.decode(OptionalBool.self, from: encodedNil) else { return XCTFail("Failed to decode encoded Optional Null Omitting Bool Object") }
        XCTAssert(decodedNil.testValue == nil, "Optional Null Omitting Bool Object Decoded Incorrectly")
    }
}

