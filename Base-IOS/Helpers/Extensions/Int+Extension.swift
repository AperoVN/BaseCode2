//
//  Int+Extension.swift
//  EndUserAI
//
//  Created by TrinhDV on 12/9/20.
//

import UIKit

extension Int {
    func rewriteDateTime() -> String {
        if self < 10 {
            return "0\(self)"
        }
        return "\(self)"
    }
    
    func toDuration() -> String {
        var hours: Int = 0
        var minutes: Int = 0
        var seconds: Int = 0
        
        if self >= 3600 {
            hours = self / 3600
            minutes = (self - (hours * 3600)) / 60
            if minutes > 0 {
                seconds = (self - (hours * 3600)) - (minutes * 60)
            } else {
                seconds = self - (hours * 3600)
            }
        } else if self >= 60 {
            minutes = self / 60
            seconds = self - (minutes * 60)
        } else {
            seconds = self
        }
        
        if hours == 0 {
            return "\(minutes.rewriteDateTime()):\(seconds.rewriteDateTime())"
        }
        
        return "\(hours.rewriteDateTime()):\(minutes.rewriteDateTime()):\(seconds.rewriteDateTime())"
    }
    
    func toPages(perPage: Int) -> Int {
        if self == 0 { return self }
        
        if self < perPage && self != 0 {
            return 1
        } else {
            if self % perPage == 0 {
                return self / perPage
            } else {
                return (self / perPage) + 1
            }
        }
    }
    
    func returnMonth() -> Int {
        var number = self
        if self > 12 {
            number = self - 12
        }
        return number
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
