//
//  UITableViewCell+Extension.swift
//  EndUserAI
//
//  Created by IchNV on 12/1/20.
//

import UIKit

extension UITableViewCell {
    static var name: String {
        return String(describing: self)
    }
}

// MARK: Methods
extension UITableViewCell {
    static var cellName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    static var nibName: String {
        return cellName
    }
    
    static var reuseIdentifier: String {
        return cellName
    }
}
