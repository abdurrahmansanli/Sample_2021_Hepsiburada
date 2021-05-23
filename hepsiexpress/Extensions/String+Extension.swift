//
//  String+Extension.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 23.05.2021.
//

import UIKit

enum DateInputFormatType: String {
    case type1 = "yyyy-MM-dd'T'HH:mm:ssZ"
}

extension String {
    
    func getFormattedDateString(dateInputFormatType: DateInputFormatType = .type1, outputFormat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateInputFormatType.rawValue

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = outputFormat

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
           return ""
        }
    }
    
    func getDate(dateInputFormatType: DateInputFormatType = .type1) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = dateInputFormatType.rawValue
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
    
    func getRemainingTimeString(hoursIndicator: String = "Hours",
                                minutesIndicator: String = "Minutes",
                                secondsIndicator: String = "Seconds",
                                prefixIndicator: String? = "Remaining") -> String? {
        var remainingString = ""
        let fromDate = Date()
        guard let toDate = self.getDate() else { return nil }
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: fromDate, to: toDate)
        if let hours = diffComponents.hour, hours > 0 {
            remainingString = remainingString + "\(hours) \(hoursIndicator) "
        }
        if let minutes = diffComponents.minute, minutes > 0 {
            remainingString = remainingString + "\(minutes) \(minutesIndicator) "
        }
        if let seconds = diffComponents.second, seconds > 0 {
            remainingString = remainingString + "\(seconds) \(secondsIndicator) "
        }
        if remainingString == "" {
            return nil
        } else if let prefixIndicator = prefixIndicator {
            remainingString = remainingString + "\(prefixIndicator)"
        }
        return remainingString
    }
}
