//
//  Date+.swift
//  stravaclone
//
//  Created by Momo Khan on 5/28/25.
//

import Foundation

extension Date {
    var localizedDateWithoutWeekdayAndTimezone: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = false
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}
