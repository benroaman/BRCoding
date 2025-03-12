//
//  ISO8601DateFormatter+utils.swift
//
//
//  Created by Ben Roaman on 3/12/25.
//

import Foundation

internal extension ISO8601DateFormatter {
    func getDateFromString(_ str: String, with backups: [DateFormatter]) -> Date? {
        if let result = date(from: str) {
            return result
        } else {
            for backup in backups {
                if let result = backup.date(from: str) {
                    return result
                }
            }
        }
        
        return nil
    }
}
