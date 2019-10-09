#!/usr/bin/swift
//  life
//  Created by pqso on 2019/10/9.
//  Copyright © 2019 pqso. All rights reserved.

import Foundation

func getSubTitle(_ count: Int, total: Int) -> String {
    let finished = "■"
    let unFinished = "□"

    let percent = Double(count)  / Double(total)
    let f = lrint(30 * percent)
    let uF = 30 - f
    
    return String(repeating: finished, count: f) + String(repeating: unFinished, count: uF) + " \(lrint(percent * 100))%"
}

struct Life{
    enum Style: String{
        case hoursInDay = "hoursInDay"
        case dayInWeek = "dayInWeek"
        case weekInYear = "weekInYear"
        case dayInMonth = "dayInMonth"
        case monthInYear = "monthInYear"
    }
    let style: Style
    var alfredItem: [String: String] = [:]
    
    init(_ style: Style) {
        let calendar = Calendar.current
        let date = Date()
        let year = calendar.component(.year, from: date)
        
        var dic: [String : String] = [:]
        switch style {
            case .hoursInDay:
                let hour = calendar.component(.hour, from:date)
                dic = ["title": "今天已经过去了 \(hour) 小时", "subtitle": getSubTitle(hour, total: 23), "arg": "这是一个测试"]
            case .dayInWeek:
                let day = calendar.component(.weekday, from: date)
                dic = ["title": "本周已过去了 \(day - 1) 天", "subtitle": getSubTitle(day - 1, total: 7)]
            case .weekInYear:
                let weekRange = calendar.range(of: .weekOfYear, in: .yearForWeekOfYear, for: Date())!
                let week = calendar.component(.weekOfYear, from: date)
                dic = ["title": "\(year) 年已经过去了 \(week - 1) 周", "subtitle": getSubTitle(week - 1, total: weekRange.count)]
            case .dayInMonth:
                let dayth = calendar.component(.day, from: date)
                let monthRange = calendar.range(of: .day, in: .month, for: date)!
                dic = ["title": "这个月已经过去了 \(dayth - 1) 天", "subtitle": getSubTitle(dayth - 1, total: monthRange.count)]
            case .monthInYear:
                let month = calendar.component(.month, from: date)
                dic = ["title": "\(year) 年已经过去了 \(month - 1) 个月", "subtitle": getSubTitle(month - 1, total: 12)]
        }
        self.style = style
        dic["arg"] = dic["title"]! + "\n" + dic["subtitle"]!
        alfredItem = dic
    }
}

let hoursInDay = Life(.hoursInDay).alfredItem
let dayInWeek = Life(.dayInWeek).alfredItem
let weekInYear = Life(.weekInYear).alfredItem
let dayInMonth = Life(.dayInMonth).alfredItem
let monthInYear = Life(.monthInYear).alfredItem

let alfredItems = ["items": [hoursInDay, dayInWeek, dayInMonth, weekInYear, monthInYear]]
let resultData = try JSONSerialization.data(withJSONObject: alfredItems, options: .prettyPrinted)
print(String(data: resultData, encoding: .utf8)!)
