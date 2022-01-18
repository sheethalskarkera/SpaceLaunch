//
//  DateFormatter+Extension.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 19/1/22.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let currentLocaleFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
}
