//
//  MainDependencyContainer.swift
//  Human Apps Test
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import Human_Apps_Test_UI

public final class MainDependencyContainer {
    
    private var router: MainRouter!
    
    init() {}
    
    func createRootViewController() -> UIViewController {
        let navigationController = UINavigationController()
        
        let routerViewModel = MainRouterViewModel()
        
        let mainViewController = createMainVC(
            navigationManager: routerViewModel
        )
        
        router = MainRouter(
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
extension MainDependencyContainer {
    
    private func createMainVC(
        navigationManager: PhotoPickerPresenter
    ) -> UIViewController {
        let viewModel = MainViewModel(
            navigationManager: navigationManager
        )
        
        let viewController = MainViewController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
