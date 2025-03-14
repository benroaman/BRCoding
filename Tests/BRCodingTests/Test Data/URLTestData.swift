//
//  URLTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct URLTestData {
    private init() { }
    
    static let validURLString = "https://github.com/"
    static let validURLJSONData = (try? JSONEncoder().encode(["testValue": validURLString]))!
    static let validURLJSON = String(data: validURLJSONData, encoding: .utf8)!
    static let invalidURLJSONData = #"{"testValue":""}"#.data(using: .utf8)!
    static let invalidTypeJSONData = #"{"testValue":12345}"#.data(using: .utf8)!
}
