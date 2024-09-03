//
//  MainViewControllerView.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 11.08.24.
//

import UIKit

private struct Constants {
    static let FILTERS_HEIGHT: CGFloat = 30
    static let FILTER_ITEMS = [
        "Original",
        "Black/White"
    ]
    static let SAVE_ICON_NAME = "square.and.arrow.down"
    static let SAVE_TITLE = "Save"
    static let SAVE_SIZE: CGFloat = 16
    static let DISPLAY_TITLE = "+"
    static let DISPLAY_SIZE: CGFloat = 50
}

public final class MainViewControllerView: UIView {
    
    public private(set) var leftBarButtonItem: UISegmentedControl = {
        let control = UISegmentedControl(
            items: Constants.FILTER_ITEMS
        )
        control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.isDoubleSided = false
        control.selectedSegmentTintColor = .white
        control.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.black
            ],
            for: .normal
        )
        control.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.black
            ],
            for: .selected
        )
        
        return control
    }()
    public private(set) var rightBarButtonItem: UIButton = {
        let button = HighlightedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.isDoubleSided = false
        button.setImage(
            UIImage(
                systemName: Constants.SAVE_ICON_NAME
            ),
            for: .normal
        )
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.SAVE_SIZE
        )
        button.setTitleColor(
            .black,
            for: .normal
        )
        button.setTitle(
            Constants.SAVE_TITLE,
            for: .normal
        )
        
        return button
    }()
    public private(set) var displayPhotoPickerButton: UIButton = {
        let button = HighlightedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.isDoubleSided = false
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.DISPLAY_SIZE
        )
        button.setTitleColor(
            .black,
            for: .normal
        )
        button.setTitle(
            Constants.DISPLAY_TITLE,
            for: .normal
        )
        
        return button
    }()
    private(set) var viewWithImage: MainViewWithImage?
    
    public override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        backgroundColor = .white
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard displayPhotoPickerButton.frame == .zero && frame != .zero else {
             return
        }
        
        leftBarButtonItem.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width / 5,
            height: Constants.FILTERS_HEIGHT
        )
        
        layoutElements()
    }
}

// MARK: - PUBLIC HELPERS
extension MainViewControllerView {
    
    public func updateSelf(
        imageData: Data
    ) {
        displayPhotoPickerButton.removeFromSuperview()
        
        let viewWithImage = MainViewWithImage(
            imageData: imageData
        )
        
        self.viewWithImage = viewWithImage
        
        addSubview(viewWithImage)
        
        NSLayoutConstraint.activate([
            viewWithImage.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            viewWithImage.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            viewWithImage.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            viewWithImage.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

// MARK: - LAYOUT HELPERS
extension MainViewControllerView {
    
    private func layoutElements() {
        addSubview(displayPhotoPickerButton)
        
        NSLayoutConstraint.activate([
            displayPhotoPickerButton.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            displayPhotoPickerButton.centerXAnchor.constraint(
                equalTo: centerXAnchor
            )
        ])
    }
}
