//
//  PhotoPickerManager.swift
//  Human Apps Test Core
//
//  Created by Илья Салей on 11.08.24.
//

import Photos

public final class PhotoPickerManager {
    
    public init() {}
}

extension PhotoPickerManager: PhotoPickerManagerProtocol {
    
    public func requestPhotoLibraryStatus() -> PHAuthorizationStatus {
        PHPhotoLibrary.authorizationStatus()
    }
    
    public func requestAuthorization(
        handler: @escaping ((PHAuthorizationStatus) -> Void)
    ) {
        PHPhotoLibrary.requestAuthorization(
            for: .readWrite,
            handler: handler
        )
    }
}
