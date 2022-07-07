//
//  Constants.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import UIKit

public typealias VoidBlock = () -> Void
public typealias BoolBlock = (Bool) -> Void
public typealias StringBlock = (String) -> Void
public typealias IntBlock = (Int) -> Void

struct Constants {
    
    struct DateFormat {
        static let datePatternZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        static let normalDatePattern = "yyyy/MM/dd"
    }
    
    struct Numbers {
        static let numberFirstLanguage: Int = 5
    }
    
    struct Keys {
        static let KEY_FIRST_LANGUAGE = "KEY_FIRST_LANGUAGE"
    }
    
    struct Colors {
        static let blackColor           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let black333             = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
        static let growTextColor        = #colorLiteral(red: 0.4196078431, green: 0.4196078431, blue: 0.4196078431, alpha: 1)
        static let redTextColor         = #colorLiteral(red: 1, green: 0.3215686275, blue: 0.1725490196, alpha: 1)
        static let primaryColor         = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        static let whiteColor           = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let growBG               = #colorLiteral(red: 0.8980392157, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        static let blueLinkColor        = #colorLiteral(red: 0.1450980392, green: 0.5450980392, blue: 0.8705882353, alpha: 1)
        static let blueTextColor        = #colorLiteral(red: 0.09019607843, green: 0.5137254902, blue: 0.862745098, alpha: 1)

        static let leftColor            = #colorLiteral(red: 0, green: 0.6392156863, blue: 0.9294117647, alpha: 1)
        static let rightColor           = #colorLiteral(red: 0, green: 0.3843137255, blue: 0.831372549, alpha: 1)

        static let stateOkColor         = #colorLiteral(red: 0.01960784314, green: 0.6823529412, blue: 0.937254902, alpha: 1)
        static let stateNotOkColor      = #colorLiteral(red: 1, green: 0.3215686275, blue: 0.1725490196, alpha: 1)
        static let stateMediumColor     = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)

        static let shadowColor          = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20)
    }
    
}
