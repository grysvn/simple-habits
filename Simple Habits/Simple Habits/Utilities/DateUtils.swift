//
//  DateUtils.swift
//  Simple Habits
//
//  Created by Matthew Gray on 7/7/21.
//

import Foundation

class DateUtils {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter
    }()

    static func gmtDayString(from date: Date) -> String {
        return formatter.string(from: date)
    }
}
