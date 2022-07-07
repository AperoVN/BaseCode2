//
//  SplashVC.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = LanguagesVC(LanguagesViewModel(isInSettings: false))
        NavigationHelper.setRoot(withVC: vc)
    }
    
}
