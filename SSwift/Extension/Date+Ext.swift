//
//  date.swift
//  FinstroPay
//
//  Created by sondang on 5/9/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension Date {
    
    private static func serverCalendar() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }
    
    private static func curentCalendar() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current
        
        return calendar
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static func toDate(date: String!, format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: date)!
    }
    
}

extension Date {
    
    func yearsSince() -> Int {
        let calendar = Date.curentCalendar()
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.year], from: date1, to: date2)
        
        return components.year!
    }
    
    static func isLeapYear(year: Int!) -> Bool {
        if year%400 == 0 {
            return true
        }
        
        if year%100 == 0 {
            return false
        }
        
        if (year % 4 == 0){
            return true;
        }
        
        return false
    }
    
    static func currentYear() -> Int! {
        return Int(Date().toString(format: "YYYY"))
    }
    
    static func dateFrom(date: Int!, month: Int!, year: Int!) -> Date {
        //calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = DateComponents(year: year, month: month, day: date)
        return Date.curentCalendar().date(from: components)!
    }
    
    func isUnder18() -> Bool {
        if self.yearsSince() >= 18 {
            return false
        }
        return true
    }
    
    static func dateFromInterval(_ timeInterval: Double?) -> Date {
        // for milisecond
        if timeInterval != nil {
            return Date(timeIntervalSince1970: timeInterval!/1000)
        }
        
        return Date()
    }
    
    func daySuffix() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let dayOfMonth = calendar.component(.day, from: self)
        switch dayOfMonth {
            case 1, 21, 31: return "st"
            case 2, 22: return "nd"
            case 3, 23: return "rd"
            default: return "th"
        }
    }
    
    func toStringShortFormat() -> String {
        return self.toString(format: "EE, ") + self.toString(format: "dd") + self.daySuffix() + self.toString(format: " MMM")
    }
    
    static func timestampOfCurrent() -> String {
        let calendar = Date.curentCalendar()
        let datetime = calendar.startOfDay(for: Date())
        
        let year = datetime.toString(format: "YYYY")
        let month = datetime.toString(format: "MM")
        let date = datetime.toString(format: "dd")
        
        let hour = datetime.toString(format: "HH")
        let minute = datetime.toString(format: "mm")
        let second = datetime.toString(format: "ss")
        return "\(year)\(month)\(date)\(hour)\(minute)\(second)"
    }
    
    func gotoNext(value: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: value, to: self)
    }
    
}
