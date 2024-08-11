//
//  MainViewModel.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

public final class MainViewModel {
    
    private(set) var navigationManager: PhotoPickerPresenter
    
    public init(
        navigationManager: PhotoPickerPresenter
    ) {
        self.navigationManager = navigationManager
    }
}
