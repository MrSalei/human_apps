//
//  TabBarDependencyContainer.swift
//  Human Apps Test
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import Human_Apps_Test_UI

final class TabBarDependencyContainer {
    
    func createTabBarViewController() -> UIViewController {
        let mainRootViewController = MainDependencyContainer().createRootViewController()
        
        let settingsRootViewController = SettingsDependencyContainer().createRootViewController()
        
        let viewController = TabBarViewController(
            viewControllers: [
                mainRootViewController,
                settingsRootViewController
            ]
        )
        
        return viewController
    }
}
