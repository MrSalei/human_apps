//
//  SettingsDependencyContainer.swift
//  Human Apps Test
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import Human_Apps_Test_UI

public final class SettingsDependencyContainer {
    
    private var router: SettingsRouter!
    
    init() {}
    
    func createRootViewController() -> UIViewController {
        let navigationController = UINavigationController()
        
        let routerViewModel = SettingsRouterViewModel()
        
        let mainViewController = createMainVC(
            navigationManager: routerViewModel
        )
        
        router = SettingsRouter(
            viewModel: routerViewModel,
            navigationController: navigationController
        )
        
        navigationController.viewControllers = [
            mainViewController
        ]
        
        return navigationController
    }
}

// MARK: - CREATION HELPERS
extension SettingsDependencyContainer {
    
    private func createMainVC(
        navigationManager: SystemAlertPresenter
    ) -> UIViewController {
        let viewModel = SettingsMainViewModel(
            navigationManager: navigationManager
        )
        
        let viewController = SettingsMainViewController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
