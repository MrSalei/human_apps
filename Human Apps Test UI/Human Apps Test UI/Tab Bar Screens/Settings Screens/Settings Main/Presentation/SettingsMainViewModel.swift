//
//  SettingsMainViewModel.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation
import Combine

private struct Constants {
    static let ABOUT_APP = "About app"
}

public final class SettingsMainViewModel {
    
    private(set) var navigationManager: SystemAlertPresenter
    
    private(set) var updateTableSender = PassthroughSubject<Void, Never>()
    
    var tableViewData: [String] = [
        Constants.ABOUT_APP
    ]
    
    public init(
        navigationManager: SystemAlertPresenter
    ) {
        self.navigationManager = navigationManager
    }
}

// MARK: - HELPERS
extension SettingsMainViewModel {
    
    public func addNewItem() {
        tableViewData += [
            Constants.ABOUT_APP
        ]
        
        updateTableSender.send()
    }
}
