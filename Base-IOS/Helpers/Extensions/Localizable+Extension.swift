//
//  Localizable+Extension.swift
//  PDFEditor
//
//  Created by ANH VU on 03/06/2022.
//

import Foundation
import UIKit

// MARK: - Localized
protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized(), for: .normal)
        }
   }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set {
            text = newValue?.localized()
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set {
            placeholder = newValue?.localized()
        }
    }
}
