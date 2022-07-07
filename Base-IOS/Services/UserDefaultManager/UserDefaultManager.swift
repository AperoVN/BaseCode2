//
//  UserDefaultManager.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//

import UIKit

extension UserDefaults {
    var isFirtLanguage: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Keys.KEY_FIRST_LANGUAGE)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.Keys.KEY_FIRST_LANGUAGE)
        }
    }
}
