//
//  BRCEnumWithFallback.swift
//
//
//  Created by Ben Roaman on 3/14/25.
//

import Foundation

public protocol BRCEnumWithFallback: RawRepresentable, Codable {
    static var fallbackCase: Self { get }
}
