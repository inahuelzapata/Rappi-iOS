//
//  CollectionViewViewModelProtocol.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewViewModelProtocol {
    var cell: CollectionViewCell.Type { get }
    var value: Any { get }

    func config(cell: CollectionViewCell, data: Any, indexPath: IndexPath, grid: Grid)
    func size(data: Any, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize
    func callback(data: Any, indexPath: IndexPath)
}
