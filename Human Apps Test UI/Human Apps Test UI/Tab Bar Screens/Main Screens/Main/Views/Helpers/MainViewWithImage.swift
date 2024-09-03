//
//  MainViewWithImage.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 15.08.24.
//

import UIKit

private struct Constants {
    static let MIN_ZOOM_SCALE: CGFloat = 1.0
    static let MAX_ZOOM_SCALE: CGFloat = 5.0
    static let BLUR_ALPHA: CGFloat = 0.5
    static let BORDER_WIDTH: CGFloat = 2
}

public final class MainViewWithImage: UIView {
    
    private var defaultImage: UIImage?
    
    public let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.isDoubleSided = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.minimumZoomScale = Constants.MIN_ZOOM_SCALE
        scrollView.maximumZoomScale = Constants.MAX_ZOOM_SCALE
        scrollView.bouncesZoom = false
        
        return scrollView
    }()
    public lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.isDoubleSided = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(
            style: .dark
        )
        let blurView = UIVisualEffectView(
            effect: blurEffect
        )
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.isDoubleSided = false
        blurView.alpha = Constants.BLUR_ALPHA
        blurView.isUserInteractionEnabled = false
        
        return blurView
    }()
    public let croppedRectangleView: UIView = {
        let view = UIView()
        view.layer.isDoubleSided = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.layer.borderWidth = Constants.BORDER_WIDTH
        view.layer.borderColor = UIColor.yellow.cgColor
        
        return view
    }()
    
    public init(
        imageData: Data
    ) {
        super.init(
            frame: .zero
        )
        
        defaultImage = UIImage(
            data: imageData
        )
        
        selectedImageView.image = defaultImage
        
        scrollView.delegate = self
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.isDoubleSided = false
        backgroundColor = .white
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard scrollView.frame == .zero && frame != .zero else {
            return
        }
        
        layoutElements()
        setupMask()
        setupRotationGesture()
    }
}

// MARK: - PUBLIC HELPERS
extension MainViewWithImage {
    
    public func displayDefaultImage() {
        selectedImageView.image = defaultImage
    }
    
    public func applyBlackWhiteFilter() {
        guard let currentImage = defaultImage else {
            return
        }
        
        let currentCIImage = CIImage(
            image: currentImage
        )

        let filter = CIFilter(
            name: "CIPhotoEffectMono"
        )
        
        filter?.setValue(
            currentCIImage,
            forKey: kCIInputImageKey
        )

        guard let outputImage = filter?.outputImage else {
            return
        }
        
        let context = CIContext()

        if let cgimg = context.createCGImage(
            outputImage,
            from: outputImage.extent
        ) {
            selectedImageView.image = UIImage(
                cgImage: cgimg
            )
        }
    }
}

// MARK: - SETUP HELPERS
extension MainViewWithImage {
    
    private func setupRotationGesture() {
        let rotationGesture = UIRotationGestureRecognizer(
            target: self,
            action: #selector(handleRotate(_:))
        )
        
        selectedImageView.addGestureRecognizer(rotationGesture)
    }
    
    private func setupMask() {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        path.addRect(bounds)

        let croppedRectangleViewFrame = croppedRectangleView.frame
        
        let rectPath = UIBezierPath(
            rect: croppedRectangleViewFrame
        )
        
        path.addPath(rectPath.cgPath)

        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        blurView.layer.mask = maskLayer
    }
}

// MARK: - @OBJC METHODS
extension MainViewWithImage {
    
    @objc func handleRotate(
        _ gesture: UIRotationGestureRecognizer
    ) {
        if gesture.state == .began || gesture.state == .changed {
            selectedImageView.transform = selectedImageView.transform.rotated(
                by: gesture.rotation
            )
            
            gesture.rotation = 0
        }
    }
}

// MARK: - LAYOUT HELPERS
extension MainViewWithImage {
    
    private func layoutElements() {
        layoutScrollView()
        layoutSelectedImageView()
        layoutBlurView()
        layoutCroppedRectangleView()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            )
        ])
    }
    
    private func layoutSelectedImageView() {
        scrollView.addSubview(selectedImageView)
        
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),
            selectedImageView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),
            selectedImageView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),
            selectedImageView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),
            selectedImageView.heightAnchor.constraint(
                equalTo: scrollView.heightAnchor
            ),
            selectedImageView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor
            )
        ])
    }
    
    private func layoutBlurView() {
        addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),
            blurView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),
            blurView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),
            blurView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            )
        ])
    }
    
    private func layoutCroppedRectangleView() {
        let width = frame.width * 0.6
        let height = frame.height * 0.5
        let xPosition = (frame.width - width) / 2
        let yPosition = (frame.height - height) / 2
        
        croppedRectangleView.frame = CGRect(
            x: xPosition,
            y: yPosition,
            width: width,
            height: height
        )
    }
}

// MARK: - UIScrollViewDelegate
extension MainViewWithImage: UIScrollViewDelegate {
    
    public func viewForZooming(
        in scrollView: UIScrollView
    ) -> UIView? {
        selectedImageView
    }
    
    public func scrollViewDidZoom(
        _ scrollView: UIScrollView
    ) {
        if scrollView.zoomScale == Constants.MIN_ZOOM_SCALE {
            scrollView.contentInset = .zero
        } else {
            let verticalInset = (scrollView.frame.height - croppedRectangleView.frame.height) / 2
            
            let horizontalInset = (scrollView.frame.width - croppedRectangleView.frame.width) / 2
            
            scrollView.contentInset = UIEdgeInsets(
                top: verticalInset,
                left: horizontalInset,
                bottom: verticalInset,
                right: horizontalInset
            )
        }
    }
}
