//
//  SettingsRouter.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import Combine

private struct Constants {
    static let TAB_BAR_ITEM_TITLE = "Settings"
}

public final class SettingsRouter: NSObject {
    
    private let viewModel: SettingsRouterViewModel
    private let navigationController: UINavigationController
    
    private(set) var cancellablesStorage = Set<AnyCancellable>()
    
    public init(
        viewModel: SettingsRouterViewModel,
        navigationController: UINavigationController
    ) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        
        super.init()
        
        customizeNavigationController()
        bindViewModel()
    }
}

// MARK: - NAVIGATION HELPERS
extension SettingsRouter {
    
    private func customizeNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        navigationController.tabBarItem.title = Constants.TAB_BAR_ITEM_TITLE
        
        let mainUnselectedImage = UIImage(
            systemName: "circle"
        )
        let mainSelectedImage = UIImage(
            systemName: "circle.fill"
        )
        
        navigationController.tabBarItem.image = mainUnselectedImage
        navigationController.tabBarItem.selectedImage = mainSelectedImage
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
    
    private func bindViewModel() {
        viewModel.systemAlertSender
            .receive(
                on: DispatchQueue.main
            )
            .sink { [weak self] alert in
                self?.presentSystemAlert(
                    with: alert
                )
            }
            .store(
                in: &cancellablesStorage
            )
    }
}

// MARK: - PRESENTATION HELPERS
extension SettingsRouter {
    
    private func presentSystemAlert(
        with alert: Alert
    ) {
        let alertController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            print("OK button tapped")
        }
        
        alertController.addAction(okAction)

        navigationController.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
}

