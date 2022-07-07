//
//  Array+Extension.swift
//  EasyScanner
//
//  Created by Quang Ly Hoang on 14/04/2022.
//

import Foundation

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}
