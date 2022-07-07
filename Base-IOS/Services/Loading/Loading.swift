//
//  Loading.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import UIKit
import PKHUD

class ProgressHUD: NSObject {
    private(set) static var isShowing = false
    
    static func show(view: UIView? = nil)  {
        guard !isShowing else { return }
        isShowing = true
        HUD.giftShow(.progress, onView: view)
    }
    
    static func hide() {
        guard isShowing else { return }
        HUD.hide(animated: true)
        isShowing = false
    }
}

extension HUD {
    public static func giftShow(_ content: HUDContentType, onView view: UIView? = nil) {
        let contentView = PKHUDProgressView(title: "", subtitle: "")
        contentView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        contentView.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        PKHUD.sharedHUD.contentView = contentView
        PKHUD.sharedHUD.show(onView: view)
    }
}
