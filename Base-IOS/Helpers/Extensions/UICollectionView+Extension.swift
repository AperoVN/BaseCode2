//
//  UICollectionView+Extension.swift
//  EndUserAI
//
//  Created by TrinhDV on 12/3/20.
//

import UIKit

// MARK: - UICollectionReusableView (Header & Footer)
enum XibCollectionSupplementaryKind {
    case header, footer
    
    var kind: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

extension UICollectionView {
    func registerNibCellFor<T: UICollectionViewCell>(type: T.Type) {
        let nibName = type.name
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: type.name)
    }
    
    func registerNibSupplementaryViewFor<T: UIView>(type: T.Type, ofKind kind: XibCollectionSupplementaryKind) {
        let nibName = type.name
        register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: kind.kind, withReuseIdentifier: nibName)
    }
    
    // MARK: - Get component functions
    func dequeueCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as! T
    }
    
    func reusableCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T? {
        let nibName = type.name
        return self.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as? T
    }
    
    func reusableSupplementaryViewFor<T: UIView>(type: T.Type, ofKind kind: XibCollectionSupplementaryKind, indexPath: IndexPath) -> T? {
        let nibName = type.name
        return self.dequeueReusableSupplementaryView(ofKind: kind.kind, withReuseIdentifier: nibName, for: indexPath) as? T
    }
    
    func cell<T: UICollectionViewCell>(type: T.Type, section: Int, item: Int) -> T? {
        guard let indexPath = validIndexPath(section: section, item: item) else { return nil }
        return self.cellForItem(at: indexPath) as? T
    }
    
    // MARK: - Supporting functions
    func validIndexPath(section: Int, item: Int) -> IndexPath? {
        guard section >= 0 && item >= 0 else { return nil }
        let itemCount = numberOfItems(inSection: section)
        guard itemCount > 0 && item < itemCount else { return nil }
        return IndexPath(item: item, section: section)
    }
}

// MARK: Methods
extension UICollectionViewCell {
    static var cellName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    static var nibName: String {
        return cellName
    }
    
    static var reuseIdentifier: String {
        return cellName
    }
}
