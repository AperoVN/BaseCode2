//
//  StringLaguage+Extension.swift
//  EasyScanner
//
//  Created by Trung on 10/08/2021.
//

import Foundation

extension String {
    func localized(_ bundle: Bundle = .main) -> String {
        return LocalizationSystem.sharedInstance.localizedStringForKey(key: self, comment: "")
    }
}
