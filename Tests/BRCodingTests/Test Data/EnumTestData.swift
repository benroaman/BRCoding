//
//  EnumTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation
import BRCoding

struct EnumTestData {
    private init() { }
    
    enum TestEnum: String, BRCEnumWithFallback {
        case hello, world, unsupported
        
        static var fallbackCase: Self { .unsupported }
    }
    
    static let validCase = TestEnum.world
    static let validCaseJSONData = (try? JSONEncoder().encode(["testValue":validCase]))!
    static let validCaseJSON = String(data: validCaseJSONData, encoding: .utf8)!
    
    static let invalidCaseJSONJData = #"{"testValue":"allmight"}"#.data(using: .utf8)!
    static let invalidTypeJSONData = #"{"testValue":12345}"#.data(using: .utf8)!
    
    static let fallbackJSON = #"{"testValue":"\#(TestEnum.fallbackCase.rawValue)"}"#
}
