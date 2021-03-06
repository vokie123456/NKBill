//
//  NKConfigure.swift
//  NKBill
//
//  Created by nick on 16/2/1.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

extension NSDate {
    
    private var componet : NSDateComponents {
        return NSCalendar.currentCalendar().components([.Era,.Day,.Month,.Year], fromDate: self)
    }
    
    var year : Int {
        return componet.year
    }
    
    var month : Int {
        return componet.month
    }
    
    var day : Int {
        return componet.day
    }
    
    /**
     这个app中采取的时间格式
     
     - returns: 特殊的时间格式
     */
    func NK_formatDate() -> String {
        let fmt = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "zh_CN")
        fmt.dateFormat = "yyyy年MM月dd日"
        return fmt.stringFromDate(self)
    }
    
    func NK_formatDate2() -> String {
        let fmt = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "zh_CN")
        fmt.dateFormat = "yyyy.MM.dd"
        return fmt.stringFromDate(self)
    }
    
    /**
     返回几个月后的时间
     
     - parameter months: 月数
     
     - returns: 加完后的时间
     */
    func NK_dateByAddingMonths(months: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = months
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateByAddingDays(days: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = days
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateByAddingHours(hours: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.hour = hours
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateBySubtractingDays(days: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = -1 * days
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateBySubtractingMonths(months: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = -1 * months
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func isBeforeToday() -> Bool {
        return self.compare(NSDate().NK_zeroMorning()) == .OrderedAscending
    }
    
    func isAfterToday() -> Bool {
        return self.compare(NSDate().NK_zeroMorning().NK_dateByAddingDays(1)) == .OrderedDescending
    }
    
    func isToday() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era,.Day,.Month,.Year], fromDate: NSDate())
        let today = calendar.dateFromComponents(components)
        let componets2 = calendar.components([.Era,.Day,.Month,.Year], fromDate: self)
        let other = calendar.dateFromComponents(componets2)
        return (today?.isEqualToDate(other!))!
    }
    // 同一天
    func isSameDay(date : NSDate) -> Bool {
        return ((self.year == date.year) && (self.month == date.month) && (self.day == date.day))
    }
    /**
     每天的零点,只包含年月日的时间（时分秒均为0）
     
     - returns: 只包含年月日的时间
     */
    func NK_zeroMorning() -> NSDate {
        
       return NSCalendar.currentCalendar().dateBySettingHour(0, minute: 0, second: 0, ofDate: self, options: NSCalendarOptions(rawValue: 0))!

    }
    
    /// 当前日的月初，比如今天是2月20日下午6点，调次函数之后返回 2月1日0点
    func NK_startOfMonth() -> NSDate {
        
        let calendar = NSCalendar.currentCalendar()
        let currentDateComponents =  calendar.components([.Month,.Year], fromDate: self)
        let startOfMonth = calendar.dateFromComponents(currentDateComponents)
        
        return startOfMonth!
    }
    
     /// 按年和月生成时间
    static func NK_dateFrom(year y: Int , month : Int) -> NSDate {
        
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.year = y
        components.month = month
        return calendar.dateFromComponents(components)!
        
    }
    
}


