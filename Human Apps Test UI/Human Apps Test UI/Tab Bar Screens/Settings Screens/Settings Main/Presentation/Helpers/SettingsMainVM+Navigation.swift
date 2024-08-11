//
//  SettingsMainVM+Navigation.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

private struct Constants {
    static let NAME: String = "Ilya"
    static let SURNAME: String = "Saley"
}

extension SettingsMainViewModel {
    
    public func presentSystemAlert() {
        let alert = Alert(
            title: Constants.NAME,
            message: Constants.SURNAME
        )
        
        navigationManager.presentSystemAlert(
            from: alert
        )
    }
}
