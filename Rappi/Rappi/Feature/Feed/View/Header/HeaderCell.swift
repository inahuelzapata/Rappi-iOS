//
//  HeaderCell.swift
//  CVVM
//
//  Created by Tibor Bödecs on 2018. 04. 13..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

import UIKit

extension UIColor {
    static let defaultGray: UIColor = {
        return UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
    }()
}

class HeaderCell: CollectionViewCell {
    @IBOutlet private weak var textLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func reset() {
        super.reset()
    }
}

extension HeaderCell {
    func renderHeader(title: String) {
        textLabel.text = title
    }
}

class HeaderViewModel: CollectionViewViewModel<HeaderCell, String> {
    override func config(cell: HeaderCell, data: String, indexPath: IndexPath, grid: Grid) {
        cell.renderHeader(title: data)
    }

    override func size(data: String, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        return grid.size(for: view, height: 48)
    }
}
