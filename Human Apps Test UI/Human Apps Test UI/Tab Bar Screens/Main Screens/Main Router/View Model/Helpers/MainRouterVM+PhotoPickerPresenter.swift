//
//  MainRouterVM+PhotoPickerPresenter.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

extension MainRouterViewModel: PhotoPickerPresenter {
    
    public func presentPhotoPicker() {
        photoPickerSender.send()
    }
}
