//
//  AppDelegate.swift
//  EasyPhone
//
//  Created by ANH VU on 13/01/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UIGestureRecognizerDelegate {
    private static var instance: AppDelegate?
    class var shared: AppDelegate {
        if self.instance == nil {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                self.instance = delegate
            }
        }
        return self.instance!
    }
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupAnimationTap()
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appNav = UINavigationController()
        let splashVC: UIViewController = SplashVC()
        appNav.viewControllers = [splashVC]
        self.window?.rootViewController = appNav
        self.window?.makeKeyAndVisible()
    }
    
    private func setupAnimationTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:_:)))
        tap.numberOfTapsRequired = 1
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer? = nil,_ touch: UITouch) {
        let location = touch.location(in: UIApplication.shared.windows.filter {$0.isKeyWindow}.first)
        let animationTap = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        var animationArray: [UIImage] = []
        for i in 1...22 {
            animationArray.append(UIImage(named: "anim_tap_\(i)")!)
        }
        animationTap.animationImages = animationArray
        animationTap.animationDuration = 1.0
        animationTap.animationRepeatCount = 1
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(animationTap)
        animationTap.center = location
        animationTap.startAnimating { success in
            animationTap.removeFromSuperview()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.handleTap(gestureRecognizer as? UITapGestureRecognizer, touch)
        return false
    }
    
}
