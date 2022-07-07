//
//  PopupConfirmVC.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import UIKit

class PopupConfirmVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    
    private let minTranform: CGFloat = 0.4
    
    private var titleStr: String?
    private var icon: UIImage?
    private var message: String?
    private var attributedMessage: NSAttributedString?
    private var cancelAction: VoidBlock?
    private var okAction: VoidBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // start state for animation
        self.view.alpha = 0.0
        self.containerView.transform = CGAffineTransform(scaleX: minTranform, y: minTranform)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animationShow()
    }
    
    init(title: String, icon: UIImage? = nil, message: String, cancel: VoidBlock?, ok: VoidBlock?) {
        super.init(nibName: nil, bundle: nil)
        self.titleStr = title
        self.icon = icon
        self.message = message
        self.cancelAction = cancel
        self.okAction = ok
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    private func setup() {
        self.lblTitle.text = self.titleStr
        self.imgIcon.image = self.icon
        self.imgIcon.isHidden = self.icon == nil
        if let attributed = self.attributedMessage {
            self.lblMessage.attributedText = attributed
        } else {
            self.lblMessage.text = self.message
        }
        self.btnCancel.isHidden = self.cancelAction == nil
        self.btnOk.isHidden = self.okAction == nil
    }
    
    // MARK: - Actions
    @IBAction private func tapCancel() {
        animationDismiss {[weak self] in
            self?.cancelAction?()
        }
    }
    
    @IBAction private func tapOK() {
        animationDismiss {[weak self] in
            self?.okAction?()
        }
    }
    
}

extension PopupConfirmVC {
    private func animationShow() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
            self.containerView.transform = .identity
        }
    }
    
    private func animationDismiss(completion: @escaping VoidBlock) {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: self.minTranform, y: self.minTranform)
        } completion: { _ in
            self.dismiss(animated: false, completion: completion)
        }
        
    }
}

extension UIViewController {
    func presentAlert(_ alert: PopupConfirmVC) {
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
}
