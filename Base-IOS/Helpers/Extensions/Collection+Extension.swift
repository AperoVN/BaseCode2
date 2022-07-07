//
//  Collection+Extension.swift
//  EndUserAI
//
//  Created by IchNV on 11/26/20.
//

import Foundation
extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
