//
//  MainViewController.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit
import PhotosUI

public final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    private let contentView = MainViewControllerView()
    
    public init(
        viewModel: MainViewModel
    ) {
        self.viewModel = viewModel
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = contentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - PHPickerViewControllerDelegate
extension MainViewController: PHPickerViewControllerDelegate {
    
    public func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        picker.dismiss(
            animated: true
        )
        
        guard let result = results.first else {
            return
        }
        
        result.itemProvider.loadObject(
            ofClass: UIImage.self
        ) { [weak self] (object, error) in
            if let image = object as? UIImage, let compressedImageData = image.jpegData(
                compressionQuality: 0.8
            ) {
                // TODO: - DISPLAY IMAGE
            }
        }
    }
}
