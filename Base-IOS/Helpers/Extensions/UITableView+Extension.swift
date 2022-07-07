//
//  Extension.swift
//  EndUserAI
//
//  Created by IchNV on 11/26/20.
//

import Foundation
import UIKit

extension UITableView {
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
    func registerCell(name: String) {
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func registerNibHeaderFooterFor<T: UIView>(type: T.Type) {
        let nibName = type.name
        register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func dequeueCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: type.interfaceId) as! T
    }
    
    func scrollToBottom(list: [Any], animated: Bool = false) {
        if !list.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                self.scrollToRow(at: IndexPath(row: list.count - 1, section: 0), at: .bottom, animated: animated)
            })
        }
    }
    
    func scrollToTop() {
        if !self.visibleCells.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
        }
    }
}
