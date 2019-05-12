//
//  LargeTitlesNavigation.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

protocol LargeTitlesNavigation where Self: UIViewController {
    func renderLargeNavigation(preferLargeTitles: Bool, displayMode: UINavigationItem.LargeTitleDisplayMode)
}

extension LargeTitlesNavigation {
    func renderLargeNavigation(preferLargeTitles: Bool = true,
                               displayMode: UINavigationItem.LargeTitleDisplayMode = .always) {
        self.navigationController?.navigationBar.prefersLargeTitles = preferLargeTitles
        self.navigationItem.largeTitleDisplayMode = displayMode
    }
}
