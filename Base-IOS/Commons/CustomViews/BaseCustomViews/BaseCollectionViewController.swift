//
//  BaseCollectionViewController.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//
import UIKit

class BaseCollectionViewController<Item, Cell: UICollectionViewCell>: UICollectionViewController {
    
    // MARK: - Variables
    var items: [Item] = [] {
        didSet { collectionView.reloadData() }
    }
    
    private var defaultRowsPerPage = 11
    var defaultHeight = 50
    var didSelect: (Item) -> () = { _ in }
    
    private var configure: (Cell, Item?, IndexPath) -> ()
        
    // MARK: - Init/Deinit
    init(items: [Item], defaultRowsPerPage: Int, defaultHeight: Int,configure: @escaping (Cell, Item?, IndexPath) -> ()) {
        self.configure = configure
        self.items = items
        self.defaultRowsPerPage = defaultRowsPerPage
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerNibCellFor(type: Cell.self)
        // estimate size collectionview
        let layoutContent = self.collectionView.collectionViewLayout
        if let flowLayout = layoutContent as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width/CGFloat(defaultRowsPerPage), height: CGFloat(defaultHeight))
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.invalidateLayout()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    // MARK: - Override Functions
    
    // ===========================
    // Tells the delegate that the item at the specified index path was selected.
    // ===========================
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = items[safe: indexPath.row] else { return }
        didSelect(item)
    }
    
    // ===========================
    // Asks your data source object for the number of items in the specified section.
    // ===========================
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultRowsPerPage
    }
    
    // ===========================
    // Asks your data source object for the cell that corresponds to the specified item in the collection view.
    // ===========================
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: Cell.self, for: indexPath)
        let itemValue = items[safe: indexPath.row]
        if itemValue != nil {
            configure(cell, itemValue, indexPath)
        } else {
            configure(cell, nil, indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width/CGFloat(defaultRowsPerPage), height: CGFloat(defaultHeight))
    }
}
