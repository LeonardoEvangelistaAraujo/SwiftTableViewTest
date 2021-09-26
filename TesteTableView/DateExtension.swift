//
//  DateExtension.swift
//  TesteTableView
//
//  Created by Leonardo Evangelista on 26/09/21.
//

import Foundation
import UIKit

extension Date {
    
    static var dayMonthYearWithoutMask = getDayMonthYearWithoutMask()
    static private func getDayMonthYearWithoutMask() -> String {
        return isEnglishPattern() ? "MMddyyyy" : "ddMMyyyy"
    }
    
    static public func getDayMonth() -> String {
        return isEnglishPattern() ? "MM/dd" : "dd/MM"
    }
    
    static var yearMonth = getYearMonth()
    static public func getYearMonth() -> String {
        return isEnglishPattern() ? "yyyy MMMM" : "MMMM 'de ' yyyy"
    }
    
    static public func getDateFormat() -> String {
        return isEnglishPattern() ? "MM/dd/yyyy" : "dd/MM/yyyy"
    }
    
    static var yearMonthDayMask = getYearMonthDay()
    static private func getYearMonthDay() -> String {
        return "yyyy-MM-dd"
    }
    
    static var hourAndMinutes = getHourAndMinutes()
    static private func getHourAndMinutes() -> String {
        if Date.isEnglishPattern() {
            return "hh:mm a"
        } else {
            return "HH:mm"
        }
    }
    
    static var shortYear = getShortYear()
    static private func getShortYear() -> String {
        if Date.isEnglishPattern() {
            return "MM/dd/yy"
        } else {
            return "dd/MM/yy"
        }
    }
    
    static var yearMask = getYear()
    static private func getYear() -> String {
        return "yyyy"
    }
    
    static var dayMonthYearTime = getDayMonthYearTime()
    static private func getDayMonthYearTime() -> String {
        if Date.isEnglishPattern() {
            return "MM/dd/yyyy '\(NSLocalizedString("AS_HORAS", comment: "Referente a hora"))' hh:mm a"
        } else {
            return "dd/MM/yyyy '\(NSLocalizedString("AS_HORAS", comment: "Referente a hora"))' HH:mm"
        }
    }
    
    static public func applyDatePattern(date: String, withPattern pattern: String) -> String {
        guard let data = dateParser().date(from: date) else {
            return NSLocalizedString("NOT_INFORMED", comment: "não informado")
        }
        let df = DateFormatter()
        df.dateFormat = pattern
        return df.string(from: data)
    }
    
    static public func getDateWithCurrentTimezone(data: String) -> String {
        guard let formatedDate = dateParser().date(from: data) else {
            return ""
        }
        let stringDate = dateParser().string(from: formatedDate)
        
        return stringDate
    }
    
    static var dateParser = { () -> ISO8601DateFormatter in
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static var isEnglishPattern = { () -> Bool in
        let locale = Locale.current
        if let regionCode = locale.regionCode {
            return regionCode.range(of: "US") != nil
        }
        
        return true
    }
    
    func convertDateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var dateToStringISO8601: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.getDateFormat() //"yyyy-MM-dd"//this your string date format
        return dateFormatter.string(from: self)
    }
    
    var dateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var hourToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.hourAndMinutes
        return dateFormatter.string(from: self)
    }
    
    var diffDateToPresentDays: Int {
        guard let days = Calendar.current.dateComponents([.day], from: self, to: Date()).day else {
            return 0
        }
        return days
    }
    
    var dateFormatterSSSZZZ: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZ"
        return dateFormatter.string(from: self)
    }
    
    var convertDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.getDateFormat()
        return dateFormatter.string(from: self)
    }
    
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    
    var convertToMinutes: Int {

        var horas  = 0
        var result = 0

        let a = formatType(form: "HH").string(from: self)
        if let b = Int(a) {
            horas = b * 60
        }

        let minutos = formatType(form: "mm").string(from: self)
        if let c = Int(minutos) {
            result = horas + c
        }

        return result

    }
    
    var secondToResetLastTrial: Double {
        let dayToSeconds = 1440
        let seconds = 60
        
        let timerNow = (dayToSeconds - self.convertToMinutes) * seconds
        return Double(timerNow)
    }
    
}
