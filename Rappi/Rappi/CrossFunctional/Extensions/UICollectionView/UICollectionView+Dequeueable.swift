//
//  UICollectionView+Dequeueable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable UICollectionViewCell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    func dequeueReusableView<T: UICollectionReusableView>(for indexPath: IndexPath, ofKind kind: String) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: T.reuseIdentifier,
                                                               for: indexPath) as? T else {
            fatalError("Unable to Dequeue UICollectionReusableView with identifier: \(T.reuseIdentifier)")
        }

        return view
    }
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusableNibCell<T: UICollectionViewCell>(_: T.Type, forBundle bundle: Bundle) {
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusableNibView<T: UICollectionReusableView>(_: T.Type, kind: String, forBundle bundle: Bundle) {
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }
}
