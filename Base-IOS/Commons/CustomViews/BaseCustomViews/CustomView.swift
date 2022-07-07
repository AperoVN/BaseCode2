//
//  CustomView.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//

import UIKit

class CustomView: UIView {
    @IBOutlet var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSelf()
        setupSubViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.clipsToBounds = true
        containerView.constraintToAllSides(of: self)
    }
    
    private func setupSelf() {
        Bundle.main.loadNibNamed(interfaceId, owner: self, options: nil)
        addSubview(containerView)
    }
    
    func setupSubViews() {}
}
