//
//  MainDependencyContainer.swift
//  Human Apps Test
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import Human_Apps_Test_UI
import Human_Apps_Test_Core

public final class MainDependencyContainer {
    
    private let photoPickerManager: PhotoPickerManagerProtocol
    private var router: MainRouter!
    
    init() {
        photoPickerManager = PhotoPickerManager()
    }
    
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
        navigationManager: PhotoPickerPresenter & SystemAlertPresenter
    ) -> UIViewController {
        let viewModel = MainViewModel(
            navigationManager: navigationManager,
            photoPickerManager: photoPickerManager
        )
        
        let viewController = MainViewController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
