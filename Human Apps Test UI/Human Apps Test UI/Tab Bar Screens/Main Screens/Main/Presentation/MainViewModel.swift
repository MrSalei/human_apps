//
//  MainViewModel.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation
import Human_Apps_Test_Core

public final class MainViewModel {
    
    private(set) var navigationManager: PhotoPickerPresenter & SystemAlertPresenter
    private(set) var photoPickerManager: PhotoPickerManagerProtocol
    
    public init(
        navigationManager: PhotoPickerPresenter & SystemAlertPresenter,
        photoPickerManager: PhotoPickerManagerProtocol
    ) {
        self.navigationManager = navigationManager
        self.photoPickerManager = photoPickerManager
    }
}
