//
//  BaseTableViewController.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//

import UIKit

class BaseTableViewController<Item, Cell: UITableViewCell>: UITableViewController {
    
    var items: [Item] = [] {
        didSet {
            if items.count <= defaultRowsPerPage {
                tableView.isScrollEnabled = false
            } else {
                tableView.isScrollEnabled = true
            }
            tableView.reloadData()
        }
    }
    
    private var defaultRowsPerPage = 8
    private var isSetHeightCell: Bool?
    
    var didSelect: (Item, IndexPath) -> () = { _, _ in }
    
    private var configure: (Cell, Item?, IndexPath) -> ()
    
    // MARK: - Init/Deinit
    init(items: [Item], defaultRowsPerPage: Int = 8, isSetHeightCell: Bool = true, configure: @escaping (Cell, Item?, IndexPath) -> ()) {
        self.configure = configure
        self.items = items
        self.defaultRowsPerPage = defaultRowsPerPage
        self.isSetHeightCell = isSetHeightCell
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.registerCell(name: Cell.name)
    }
    
    func reloadDataTable() {
        tableView.reloadData()
    }
    
    // MARK: - Override Functions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = items[safe:indexPath.row] else { return }
        didSelect(item, indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: Cell.self, for: indexPath)
        if let item = items[safe: indexPath.row] {
            configure(cell, item, indexPath)
        } else {
            configure(cell, nil, indexPath)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSetHeightCell ?? true {
            return tableView.bounds.height / CGFloat(defaultRowsPerPage)
        } else {
            return UITableView.automaticDimension
        }
        
    }
}
