//
//  SettingsRouterVM+SystemAlertPresenter.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

extension SettingsRouterViewModel: SystemAlertPresenter {
    
    public func presentSystemAlert(
        from alert: Alert
    ) {
        systemAlertSender.send(alert)
    }
}
