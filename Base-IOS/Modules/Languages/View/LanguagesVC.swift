//
//  LanguagesVC.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 28/06/2022.
//

import UIKit

class LanguagesVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var languageContainerView: UIView!
    
    // MARK: - Variables
    private var vm: LanguagesViewModel!
    
    private lazy var languageListVC: BaseTableViewController<LanguageType, LanguageCell> = {
        let vc = BaseTableViewController(items: vm.languages, isSetHeightCell: false) { (cell: LanguageCell, department, indexpath) in
            if let item = department {
                cell.config(language: item,
                            isSelected: self.vm.selectedIndex.value == indexpath.row)
            }
        }
        vc.didSelect = { [weak self] (_, indexPath) in
            guard let _self = self else { return }
            _self.vm.selectedIndex.send(indexPath.row)
        }
        return vc
    }()
    
    // MARK: - Init/Deinit
    init(_ viewModel: LanguagesViewModel) {
        self.vm = viewModel
        super.init(nibName: LanguagesVC.name, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
        install(languageListVC, toContainerView: languageContainerView)
    }
    
    // MARK: - Private Functions
    private func setupObservable() {
        vm.selectedIndex.sink {[weak self] index in
            self?.languageListVC.reloadDataTable()
            self?.navigationItem.rightBarButtonItem?.isEnabled = index != -1
        }.store(in: &vm.subscriptions)
    }
    
}
