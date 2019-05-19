//
//  CollectionCell.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class CollectionCell: CollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView! // swiftlint:disable:this private_outlet

    open var source: CollectionViewSource? = nil {
        didSet {
            self.source?.register(itemsFor: self.collectionView)

            self.collectionView.dataSource = self.source
            self.collectionView.delegate = self.source
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.backgroundColor = .defaultGray
    }

    override func reset() {
        super.reset()

        self.source = nil
    }
}
