//
//  TimeInterval+Extension.swift
//  EndUserAI
//
//  Created by TrinhDV on 12/9/20.
//

import Foundation

extension TimeInterval {
    var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 100)
    }

    var totalSeconds: Int {
        return Int(self)
    }
    
    var seconds: Int {
        return Int(self) % 60
    }

    var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    var hours: Int {
        return Int(self) / 3600
    }
    
    func toDuration() -> String {
        return "\(totalSeconds.toDuration()):\(milliseconds.rewriteDateTime())"
    }
    
    func toDurationSecond() -> String {
        return "\(totalSeconds.rewriteDateTime()).\(milliseconds.rewriteDateTime())"
    }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
