//
//  SettingsMainViewControllerView.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit

private struct Constants {
    static let ADD_TITLE = "+"
    static let ADD_SIZE: CGFloat = 50
}

public final class SettingsMainViewControllerView: UIView {
    
    static let CELL_ID = "UITableViewCell"
    
    public private(set) var rightBarButtonItem: UIButton = {
        let button = HighlightedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.isDoubleSided = false
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.ADD_SIZE
        )
        button.setTitleColor(
            .black,
            for: .normal
        )
        button.setTitle(
            Constants.ADD_TITLE,
            for: .normal
        )
        
        return button
    }()
    
    public private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.isDoubleSided = false
        tableView.backgroundColor = .white
        tableView.separatorInset.left = 0
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: SettingsMainViewControllerView.CELL_ID
        )
        
        return tableView
    }()
    
    public override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        backgroundColor = .white
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard tableView.frame == .zero && frame != .zero else {
             return
        }
        
        layoutElements()
    }
}

// MARK: - LAYOUT HELPERS
extension SettingsMainViewControllerView {
    
    private func layoutElements() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
