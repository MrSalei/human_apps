//
//  MainRouterViewModel.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation
import Combine

public final class MainRouterViewModel {
    
    private(set) var photoPickerSender = PassthroughSubject<Void, Never>()
    
    public init() {}
}
