//
//  CollectionViewCell.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.reset()
        self.contentView.backgroundColor = .defaultGray
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.reset()
    }

    func initialize() { }

    func reset() { }
}
