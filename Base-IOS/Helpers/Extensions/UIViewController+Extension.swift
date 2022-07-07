//
//  UIViewController+Extension.swift
//  EndUserAI
//
//  Created by IchNV on 11/26/20.
//

import Foundation
import UIKit

protocol XibViewController {
    static var name: String { get }
    static func create() -> Self
}

extension XibViewController where Self: UIViewController {
    static var name: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    static func create() -> Self {
        return self.init(nibName: Self.name, bundle: nil)
    }

}

extension UIViewController: XibViewController { }

extension UIViewController {
    var name: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    static func top(controller: UIViewController? = AppDelegate.shared.window?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return top(controller: navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return top(controller: presented)
        }
        if let tabController = controller as? UITabBarController {
            if tabController.moreNavigationController.viewControllers.count > 1 {
                return top(controller: tabController.moreNavigationController.visibleViewController)
            } else if let selected = tabController.selectedViewController {
                return top(controller: selected)
            }
        }
        return controller
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func pop(to: UIViewController, animated: Bool = true) {
        navigationController?.popToViewController(to, animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func popReplace() {
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers
        navigationArray.remove(at: navigationArray.count - 2)
        self.navigationController?.viewControllers = navigationArray
        self.pop()
    }
    
    func removeController(asChildViewController viewController: UIViewController) {
        if viewController.isViewLoaded {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
    }
    
    func install(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
}
