//
//  SettingsRouterViewModel.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation
import Combine

public final class SettingsRouterViewModel {
    
    private(set) var systemAlertSender = PassthroughSubject<Alert, Never>()
    
    public init() {}
}
