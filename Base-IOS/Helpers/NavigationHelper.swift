//
//  NavigationHelper.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//
import UIKit

final class NavigationHelper {
    
    static func setRoot(withVC viewcontroller: UIViewController) {
        guard let window = UIApplication.shared.windows.first else { return }
        let appNav = UINavigationController()
        appNav.viewControllers = [viewcontroller]
        window.rootViewController = appNav
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }

    static func createViewController(fromXIBType type: UIViewController.Type) -> UIViewController {
        return type.init()
    }
}
