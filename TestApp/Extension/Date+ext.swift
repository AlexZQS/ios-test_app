////
//  Date+ext.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/9/18
//
//
//

import Foundation

// MARK:- 三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
public extension Date {
    
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    /// 获取当前 秒级 时间戳 - 10 位
    static var secondStamp : String {
        let timeInterval: TimeInterval = Self().timeIntervalSince1970
        return "\(Int(timeInterval))"
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    /// 获取当前 毫秒级 时间戳 - 13 位
    static var milliStamp : String {
        let timeInterval: TimeInterval = Self().timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    // MARK: 1.3、获取当前的时间 Date
    /// 获取当前的时间 Date
    static var currentDate : Date {
        return Self()
    }
    
    // MARK: 1.4、从 Date 获取年份
    /// 从 Date 获取年份
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    // MARK: 1.5、从 Date 获取月份
    /// 从 Date 获取年份
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    // MARK: 1.6、从 Date 获取 日
    /// 从 Date 获取 日
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // MARK: 1.7、从 Date 获取 小时
    /// 从 Date 获取 日
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    /// 从 Date 获取 分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 秒
    /// 从 Date 获取 秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 毫秒
    /// 从 Date 获取 毫秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    // MARK: 1.10、从日期获取 星期(英文)
    /// 从日期获取 星期
    var weekday: String {
        let format = DateFormatter()
        format.dateFormat = "EEEE"
        return format.string(from: self)
    }
    
    // MARK: 1.11、从日期获取 月(英文)
    /// 从日期获取 月(英文)
    var monthAsString: String {
        let format = DateFormatter()
        format.dateFormat = "MMMM"
        return format.string(from: self)
    }
    
    // MARK: 2.3、Date 转换为相应格式的时间字符串，如 Date 转为 2020-10-28
    /// Date 转换为相应格式的字符串，如 Date 转为 2020-10-28
    /// - Parameter format: 转换的格式
    /// - Returns: 返回具体的字符串
    func toformatterTimeString(formatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
    
    
    // MARK: 2.5、带格式的时间转 Date，支持返回 13位 和 10位的时间戳
    /// 带格式的时间转 Date，支持返回 13位 和 10位的时间戳
    /// - Parameters:
    ///   - timesString: 时间字符串
    ///   - formatter: 格式
    /// - Returns: 返回 Date
    static func formatterTimeStringToDate(timesString: String, formatter: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        guard let date = dateFormatter.date(from: timesString) else {
#if DEBUG
            fatalError("时间有问题")
#else
            return Date()
#endif
        }
        return date
    }
    
    // MARK: 3.1、今天的日期
    /// 今天的日期
    var todayDate: Date {
        return Date()
    }
    
    // MARK: 3.2、昨天的日期
    /// 昨天的日期
    var yesterDayDate: Date? {
        return adding(day: -1)
    }
    
    // MARK: 3.3、明天的日期
    /// 明天的日期
    var tomorrowDate: Date? {
        return adding(day: 1)
    }
    
    // MARK: 3.4、前天的日期
    /// 前天的日期
    var theDayBeforYesterDayDate: Date? {
        return adding(day: -2)
    }
    
    // MARK: 3.5、后天的日期
    /// 后天的日期
    var theDayAfterYesterDayDate: Date? {
        return adding(day: 2)
    }
    
    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
    /// 是否为今天（只比较日期，不比较时分秒）
    /// - Returns: bool
    var isToday: Bool {
        let date = Date()
        if self.toformatterTimeString(formatter: "yyyyMMdd") == date.toformatterTimeString(formatter: "yyyyMMdd") {
            return true
        }
        return false
    }
    
    // MARK: 3.7、是否为昨天
    /// 是否为昨天
    var isYesterday: Bool {
        // 1.先拿到昨天的 date
        guard let date = Date().yesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return isSameYearMountDay(date)
    }
    
    // MARK: 3.8、是否为前天
    /// 是否为前天
    var isTheDayBeforeYesterday: Bool  {
        // 1.先拿到前天的 date
        guard let date = Date().theDayBeforYesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return isSameYearMountDay(date)
    }
    
    // MARK: 3.9、是否为今年
    /// 是否为今年
    var isThisYear: Bool  {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
    
    // MARK: 3.10、是否为 同一年 同一月 同一天
    /// 是否为  同一年  同一月 同一天
    /// - Returns: bool
    var isSameYearMonthDayWithToday: Bool {
        return isSameYearMountDay(Date())
    }
    
    /// 日期的加减操作
    /// - Parameter day: 天数变化
    /// - Returns: date
    private func adding(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: self)
    }
    
    /// 是否为  同一年  同一月 同一天
    /// - Parameter date: date
    /// - Returns: 返回bool
    private func isSameYearMountDay(_ date: Date) -> Bool {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let comToday = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (com.day == comToday.day &&
                com.month == comToday.month &&
                com.year == comToday.year )
    }
    
    func isSameDay3(_ date1:Date, _ date2:Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
}
