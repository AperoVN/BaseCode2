//
//  Date+Extension.swift
//  EasyPhone
//
//  Created by ANH VU on 17/01/2022.
//

import Foundation
import UIKit

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = TimeZone.current
        let dateStr = formatter.string(from: self)
        return dateStr
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        let dateStr = formatter.string(from: self)
        return dateStr
    }
    
    func toStringTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateStr = formatter.string(from: self)
        return dateStr
    }
}
