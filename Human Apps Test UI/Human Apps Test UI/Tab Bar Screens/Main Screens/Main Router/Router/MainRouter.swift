//
//  MainRouter.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import PhotosUI
import Combine

private struct Constants {
    static let TAB_BAR_ITEM_TITLE = "Main"
}

public final class MainRouter: NSObject {
    
    private let viewModel: MainRouterViewModel
    private let navigationController: UINavigationController
    
    private(set) var cancellablesStorage = Set<AnyCancellable>()
    
    public init(
        viewModel: MainRouterViewModel,
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
extension MainRouter {
    
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
        viewModel.photoPickerSender
            .receive(
                on: DispatchQueue.main
            )
            .sink { [weak self] in
                self?.presentPhotoPicker()
            }
            .store(
                in: &cancellablesStorage
            )
        
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
extension MainRouter {
    
    private func presentPhotoPicker() {
        guard let topViewController = navigationController.topViewController as? MainViewController else {
            return
        }
        
        var config = PHPickerConfiguration()
        config.filter = .any(
            of: [
                .images
            ]
        )
        
        let pickerViewController = PHPickerViewController(
            configuration: config
        )
        pickerViewController.delegate = topViewController
        pickerViewController.modalPresentationStyle = .overCurrentContext
        
        navigationController.present(
            pickerViewController,
            animated: true,
            completion: nil
        )
    }
    
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
        ) { [weak self] _ in
            print("OK button tapped")
            self?.presentSettings()
        }
        
        alertController.addAction(okAction)

        navigationController.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    private func presentSettings() {
        guard let settingsUrl = URL(
            string: UIApplication.openSettingsURLString
        ) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(
                settingsUrl,
                completionHandler: nil
            )
        }
    }
}
