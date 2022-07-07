//
//  GradientView.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import UIKit


/// Gradient
///
/// UIRectCorner.topLeft = 1
///
/// UIRectCorner.topRight = 2
///
/// UIRectCorner.bottomLeft = 4
///
/// UIRectCorner.bottomRight = 8
///
class GradientView: UIView {
    @IBInspectable var startColor:   UIColor = .white { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startCornerValue: UInt = UIRectCorner.topLeft.rawValue { didSet { updatePoints() }}
    @IBInspectable var endCornerValue: UInt = UIRectCorner.topRight.rawValue { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    override init(frame: CGRect) {
        super.init(frame: frame)
        updatePoints()
        updateColors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updatePoints()
        updateColors()
    }
    
    private func updatePoints() {
        gradientLayer.startPoint = UIRectCorner(rawValue: startCornerValue).point
        gradientLayer.endPoint = UIRectCorner(rawValue: endCornerValue).point
    }
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateColors()
    }
}

extension UIRectCorner {
    var point: CGPoint {
        switch self {
        case .topLeft: return .zero
        case .topRight: return CGPoint(x: 1, y: 0)
        case .bottomLeft: return CGPoint(x: 0, y: 1)
        case .bottomRight: return CGPoint(x: 1, y: 1)
        default: return .zero
        }
    }
}
