//
//  TableViewHeader.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class TableViewHeader: UIView {
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension TableViewHeader {
    func render(title: String) {
        self.titleLabel.text = title
    }
}

extension TableViewHeader: Dequeueable { }

extension TableViewHeader: DequeueableNib { }
