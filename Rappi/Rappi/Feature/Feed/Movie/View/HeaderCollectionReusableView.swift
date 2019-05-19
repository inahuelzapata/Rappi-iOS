//
//  HeaderCollectionReusableView.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet private weak var titleLabel: UILabel!

    var title: String = "Placeholder"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension HeaderCollectionReusableView {
    func renderTitle(_ title: String) {
        titleLabel.text = title
    }
}
