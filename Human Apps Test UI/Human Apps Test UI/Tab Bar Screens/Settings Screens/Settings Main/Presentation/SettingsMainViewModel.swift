//
//  SettingsMainViewModel.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

public final class SettingsMainViewModel {
    
    private(set) var navigationManager: SystemAlertPresenter
    
    public init(
        navigationManager: SystemAlertPresenter
    ) {
        self.navigationManager = navigationManager
    }
}
