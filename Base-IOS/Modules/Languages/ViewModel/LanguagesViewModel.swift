//
//  LanguagesViewModel.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//

import UIKit
import Combine

final class LanguagesViewModel {
    // MARK: - Variables
    var isInSettings: Bool = true
    var languages: [LanguageType] = []
    var selectedIndex = CurrentValueSubject<Int, Never>(-1)
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init/Deinit
    init(isInSettings: Bool) {
        self.isInSettings = isInSettings
        isInSettings ? configSettings() : configFirstOpenApp()
    }
    
    // MARK: - Private Functions
    private func configFirstOpenApp() {
        languages = LanguageType.allCases
        let languageKey = LocalizationSystem.sharedInstance.getLanguage()
        if let language = LanguageType(rawValue: languageKey), let index = languages.firstIndex(of: language) {
            languages.rearrange(from: index, to: 0)
            languages = Array(languages.prefix(Constants.Numbers.numberFirstLanguage))
            // get first 5 language
            selectedIndex.send(0)
        } else {
            languages = Array(languages.prefix(Constants.Numbers.numberFirstLanguage))
            selectedIndex.send(0)
        }
    }
    
    private func configSettings() {
        languages = LanguageType.allCases
        let languageKey = LocalizationSystem.sharedInstance.getLanguage()
        if let language = LanguageType(rawValue: languageKey) {
            selectedIndex.send(languages.firstIndex(of: language) ?? -1)
        } else {
            selectedIndex.send(-1)
        }
    }
}
