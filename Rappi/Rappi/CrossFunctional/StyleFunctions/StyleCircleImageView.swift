//
//  StyleCircleImageView.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

/// StyleCircleImageView
/// - Parameters:
/// UIImageView: Need an instance of UIImageView
/// to apply this style.
let styleCircleImageView: ((UIImageView) -> Void) = {
    $0.layer.masksToBounds = false
    $0.layer.cornerRadius = $0.frame.height / 2
    $0.clipsToBounds = true
}
