//
//  LanguageCell.swift
//  EasyScanner
//
//  Created by Quang Ly Hoang on 13/04/2022.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        languageLabel.text = nil
        checkImageView.isHidden = true
    }
    
    func config(language: LanguageType, isSelected: Bool) {
        iconImageView.image = language.icon
        languageLabel.text = language.title
        checkImageView.isHidden = !isSelected
    }
    
}
