//
//  TabBarViewController.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit

public final class TabBarViewController: UITabBarController {
    
    public init(
        viewControllers: [UIViewController]
    ) {
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.viewControllers = viewControllers
        
        self.tabBarItem.title = "Home"
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - SETUP HELPERS
extension TabBarViewController {
    
    private func setupView() {
        view.backgroundColor = .white
    }
}
