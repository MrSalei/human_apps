//
//  SettingsMainViewController.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit

public final class SettingsMainViewController: UIViewController {
    
    private let viewModel: SettingsMainViewModel
    private let contentView = SettingsMainViewControllerView()
    
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
        
    }
}
