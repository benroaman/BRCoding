//
//  BRSelfValidatingServerEntity.swift
//
//
//  Created by Ben Roaman on 3/9/25.
//

import Foundation

protocol BRSelfValidatingServerEntity: Codable {
    var isValid: Bool { get }
}
