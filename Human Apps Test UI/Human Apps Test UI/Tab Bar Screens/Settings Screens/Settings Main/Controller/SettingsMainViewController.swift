//
//  SettingsMainViewController.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import Combine

public final class SettingsMainViewController: UIViewController {
    
    private let viewModel: SettingsMainViewModel
    private let contentView = SettingsMainViewControllerView()
    
    public var router: SettingsRouter?
    
    private(set) var cancellablesStorage = Set<AnyCancellable>()
    
    public init(
        viewModel: SettingsMainViewModel
    ) {
        self.viewModel = viewModel
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = contentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupDelegates()
        setupActions()
        bindViewModel()
    }
}

// MARK: - SETUP HELPERS
extension SettingsMainViewController {
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: contentView.rightBarButtonItem
        )
    }
    
    private func setupDelegates() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    private func setupActions() {
        contentView.rightBarButtonItem.addTarget(
            self,
            action: #selector(rightBarButtonItemWasPressed),
            for: .touchUpInside
        )
    }
    
    private func bindViewModel() {
        viewModel.updateTableSender
            .receive(
                on: DispatchQueue.main
            )
            .sink { [weak self] in
                self?.contentView.tableView.reloadData()
            }
            .store(
                in: &cancellablesStorage
            )
    }
}

// MARK: - @OBJC METHODS
extension SettingsMainViewController {
    
    @objc private func rightBarButtonItemWasPressed() {
        viewModel.addNewItem()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.tableViewData.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsMainViewControllerView.CELL_ID,
            for: indexPath
        )
        cell.layer.isDoubleSided = false
        
        guard indexPath.row >= 0 && indexPath.row < viewModel.tableViewData.count else {
            return cell
        }
        
        cell.textLabel?.text = viewModel.tableViewData[indexPath.row]
        
        return cell
    }
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath, 
            animated: false
        )
        
        viewModel.presentSystemAlert()
    }
}
