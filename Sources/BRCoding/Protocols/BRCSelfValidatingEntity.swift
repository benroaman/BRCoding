//
//  BRCSelfValidatingEntity.swift
//
//
//  Created by Ben Roaman on 3/9/25.
//

import Foundation

protocol BRCSelfValidatingEntity: Codable {
    var isValid: Bool { get }
}
