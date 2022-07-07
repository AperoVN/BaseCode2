//
//  LanguageModel.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//

import UIKit

enum LanguageType: String, CaseIterable {
    case english = "en"
    case spanish = "es"
    case portuguese = "pt-PT"
    case hindi = "hi"
    case german = "de"
    case japanese = "ja"
    case korean = "ko"
    case french = "fr"
    case malay = "ms"
    case filipino = "fil"
    case indonesian = "id"
    case dutch = "nl"
    case chinese = "zh-Hant"
    case italian = "it"
    case russian = "ru"
    
    init?(rawValue: String) {
        if let type = LanguageType.allCases.filter({ rawValue.hasPrefix($0.rawValue) }).first {
            self = type
        } else {
            return nil
        }
    }
    
    var title: String {
        switch self {
            case .english:
                return "English"
            case .hindi:
                return "हिन्दी"
            case .german:
                return "Deutsch"
            case .japanese:
                return "日本"
            case .korean:
                return "한국인"
            case .french:
                return "La France"
            case .spanish:
                return "Español"
            case .portuguese:
                return "Português"
            case .malay:
                return "Malaysia"
            case .filipino:
                return "Filipina"
            case .indonesian:
                return "Bahasa Indonesia"
            case .dutch:
                return "Nederlands"
            case .chinese:
                return "中国人"
            case .italian:
                return "Italiano"
            case .russian:
                return "Русский"
        }
    }
    
    var icon: UIImage? {
        switch self {
            case .english:
                return UIImage(named: "ic_english")
            case .hindi:
                return UIImage(named: "ic_india")
            case .german:
                return UIImage(named: "ic_german")
            case .japanese:
                return UIImage(named: "ic_japan")
            case .korean:
                return UIImage(named: "ic_korean")
            case .french:
                return UIImage(named: "ic_france")
            case .spanish:
                return UIImage(named: "ic_spain")
            case .portuguese:
                return UIImage(named: "ic_portugal")
            case .malay:
                return UIImage(named: "ic_malaysia")
            case .filipino:
                return UIImage(named: "ic_philipines")
            case .indonesian:
                return UIImage(named: "ic_indonesia")
            case .dutch:
                return UIImage(named: "ic_netherland")
            case .chinese:
                return UIImage(named: "ic_china")
            case .italian:
                return UIImage(named: "ic_italy")
            case .russian:
                return UIImage(named: "ic_russia")
        }
    }
}
