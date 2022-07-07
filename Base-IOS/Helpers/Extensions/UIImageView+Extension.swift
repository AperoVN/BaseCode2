//
//  UIImageView+Extension.swift
//  LoveMemory
//
//  Created by Ha Nguyen Duc on 2022/01/07.
//

import SDWebImage
import UIKit

extension UIImageView {
    func setImage(with urlString: String, placeholderImage: UIImage? = nil, completion: SDExternalCompletionBlock? = nil) {
        SDWebImageDownloader.shared.setValue("ua-lovememo", forHTTPHeaderField: "User-Agent")
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholderImage, completed: completion)
    }
}
