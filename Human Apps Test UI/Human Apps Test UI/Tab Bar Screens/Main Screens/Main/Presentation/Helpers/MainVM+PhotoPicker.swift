//
//  MainVM+PhotoPicker.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import Foundation

extension MainViewModel {
    
    public func requestPhotoLibraryStatus() {
        let status = photoPickerManager.requestPhotoLibraryStatus()
        
        switch status {
        case .authorized, .limited:
            navigationManager.presentPhotoPicker()
        case .notDetermined:
            photoPickerManager.requestAuthorization { [weak self] status in
                switch status {
                case .authorized, .limited:
                    self?.navigationManager.presentPhotoPicker()
                default:
                    self?.presentSystemAlert()
                }
            }
        default:
            presentSystemAlert()
        }
    }
}
