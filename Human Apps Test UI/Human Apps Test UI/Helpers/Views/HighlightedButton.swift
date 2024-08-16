//
//  HighlightedButton.swift
//  Human Apps Test UI
//
//  Created by Илья Салей on 15.08.24.
//

import UIKit

private struct Constants {
    static let HIGHLIGHTED_ALPHA: CGFloat = 0.5
    static let MAIN_ALPHA: CGFloat = 1.0
}

public class HighlightedButton: UIButton {
    
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = Constants.HIGHLIGHTED_ALPHA
            } else {
                alpha = Constants.MAIN_ALPHA
            }
        }
    }
}
