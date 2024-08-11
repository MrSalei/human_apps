//
//  MainVM+Navigation.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

private struct Constants {
    static let ACCESS_DENIED_TITLE: String = "Необходимо разрешение"
    static let ACCESS_DENIED_SUBTITLE: String = "Доступ к галерее запрещен. Предоставьте его в настройках"
}

extension MainViewModel {
    
    public func presentPhotoPicker() {
        navigationManager.presentPhotoPicker()
    }
    
    public func presentSystemAlert() {
        let alert = Alert(
            title: Constants.ACCESS_DENIED_TITLE,
            message: Constants.ACCESS_DENIED_SUBTITLE
        )
        
        navigationManager.presentSystemAlert(
            from: alert
        )
    }
}
