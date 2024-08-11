//
//  PhotoPickerManagerProtocol.swift
//  Human Apps Test Core
//
//  Created by Илья Салей on 11.08.24.
//

import Photos

public protocol PhotoPickerManagerProtocol {
    func requestPhotoLibraryStatus() -> PHAuthorizationStatus
    
    func requestAuthorization(
        handler: @escaping ((PHAuthorizationStatus) -> Void)
    )
}
