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
    
    public var router: MainRouter?
    
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
        
        setupNavigation()
        setupActions()
    }
}

// MARK: - SETUP HELPERS
extension MainViewController {
    
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: contentView.leftBarButtonItem
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: contentView.rightBarButtonItem
        )
    }
    
    private func setupActions() {
        contentView.leftBarButtonItem.addTarget(
            self,
            action: #selector(segmentedControlValueChanged(_:)),
            for: .valueChanged
        )
        
        contentView.rightBarButtonItem.addTarget(
            self,
            action: #selector(rightBarButtonItemWasPressed),
            for: .touchUpInside
        )
        
        contentView.displayPhotoPickerButton.addTarget(
            self,
            action: #selector(displayPhotoPickerButtonWasPressed),
            for: .touchUpInside
        )
    }
}

// MARK: - @OBJC METHODS
extension MainViewController {
    
    @objc func segmentedControlValueChanged(
        _ sender: UISegmentedControl
    ) {
        switch sender.selectedSegmentIndex {
        case 0:
            contentView.viewWithImage?.displayDefaultImage()
        case 1:
            contentView.viewWithImage?.applyBlackWhiteFilter()
        default:
            break
        }
    }
    
    @objc private func rightBarButtonItemWasPressed() {
        guard let viewWithImage = contentView.viewWithImage else {
            return
        }
        
        // Get the rect of the small image view in the coordinate space of the big image view
        let smallImageViewRect: CGRect
        
        let scrollZoomScale = viewWithImage.scrollView.zoomScale
        if scrollZoomScale == 1 {
            smallImageViewRect = viewWithImage.selectedImageView.convert(
                viewWithImage.croppedRectangleView.frame,
                from: viewWithImage.selectedImageView
            )
        } else {
            smallImageViewRect = CGRect(
                x: (viewWithImage.scrollView.contentOffset.x + viewWithImage.scrollView.contentInset.left) / scrollZoomScale,
                y: (viewWithImage.scrollView.contentOffset.y + viewWithImage.scrollView.contentInset.top) / scrollZoomScale,
                width: viewWithImage.croppedRectangleView.frame.width / scrollZoomScale,
                height: viewWithImage.croppedRectangleView.frame.height / scrollZoomScale
            )
        }
        
        // Render the contents of the big image view into a UIImage
        let renderer = UIGraphicsImageRenderer(
            size: viewWithImage.selectedImageView.bounds.size
        )
        
        let mainImage = renderer.image { _ in
            viewWithImage.selectedImageView.drawHierarchy(
                in: viewWithImage.selectedImageView.bounds,
                afterScreenUpdates: true
            )
        }
        
        // Crop the relevant portion of the UIImage
        guard let scale = contentView.window?.windowScene?.screen.scale else {
            return
        }
        
        let cropRect = CGRect(
            x: smallImageViewRect.origin.x * scale,
            y: smallImageViewRect.origin.y * scale,
            width: smallImageViewRect.size.width * scale,
            height: smallImageViewRect.size.height * scale
        )
        
        guard let mainCgImage = mainImage.cgImage else { 
            return
        }
        
        guard let croppedCgImage = mainCgImage.cropping(
            to: cropRect
        ) else {
            return
        }
        
        let result = UIImage(
            cgImage: croppedCgImage
        )
        
        UIImageWriteToSavedPhotosAlbum(
            result,
            self,
            #selector(imageSavingCompleted(_:didFinishSavingWithError:contextInfo:)),
            nil
        )
    }
    
    @objc private func displayPhotoPickerButtonWasPressed() {
        viewModel.requestPhotoLibraryStatus()
    }
    
    @objc func imageSavingCompleted(
        _ image: UIImage,
        didFinishSavingWithError error: Error?,
        contextInfo: UnsafeRawPointer
    ) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully!")
        }
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
                DispatchQueue.main.async { [weak self] in
                    self?.contentView.updateSelf(
                        imageData: compressedImageData
                    )
                    
                    if let leftBarButtonItem = self?.contentView.leftBarButtonItem {
                        self?.segmentedControlValueChanged(leftBarButtonItem)
                    }
                }
            }
        }
    }
}
