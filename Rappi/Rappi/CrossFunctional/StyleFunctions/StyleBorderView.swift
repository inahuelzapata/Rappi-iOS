//
//  StyleBorderView.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

/// StyleBorderView
/// - Parameters:
/// - UIImageView: Need an instance of UIImageView
/// to apply this style.
/// - (CGFloat, UIColor): The first one indicates
/// the borderWidth value, and the second one
/// the color to apply to borderColor property
let styleBorderView: ((UIView, (CGFloat, UIColor)) -> Void) = {
    $0.layer.borderWidth = $1.0
    $0.layer.borderColor = $1.1.cgColor
}
