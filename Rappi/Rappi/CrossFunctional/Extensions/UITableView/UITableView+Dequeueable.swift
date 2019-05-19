//
//  UITableView+Dequeueable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell: Dequeueable { }

extension UITableViewCell: DequeueableNib { }

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    func registerReusableCell<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(_: T.Type, forBundle bundle: Bundle) {
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
