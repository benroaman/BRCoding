//
//  SetTestData.swift
//  
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

struct SetTestData {
    private init() { }
    
    static let set: Set<Int> = [1, 3, 5, 7, 11]
    static let setJSONData = (try? JSONEncoder().encode(["testValue":set]))!
    
    static let array: [Int] = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    static let arrayJSONData = (try? JSONEncoder().encode(["testValue":array]))!
    
    static let invalidTypeJSONData = #"{"testValue":"Cool Beans"}"#.data(using: .utf8)!
}
