//
//  DequeueableNib.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

protocol DequeueableNib: class {
    static var nibName: String { get }
}

extension DequeueableNib where Self: UIView {
    static var nibName: String {
        var stringFromClass = String()

        if let stringDescribing = String(describing: self).components(separatedBy: ".").last {
            stringFromClass = stringDescribing
        }

        return stringFromClass
    }
}
