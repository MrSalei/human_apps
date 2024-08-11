//
//  MainRouter.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import PhotosUI
import Combine

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
}
