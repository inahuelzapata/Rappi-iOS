//
//  CollectionViewViewModel.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

typealias CollectionViewCallback = (Any, IndexPath) -> Void

class CollectionViewViewModel<Cell, Data>: CollectionViewViewModelProtocol where Cell: CollectionViewCell, Data: Any {
    var data: Data
    var cell: CollectionViewCell.Type { return Cell.self }
    var value: Any { return self.data }

    init(_ data: Data) {
        self.data = data
        self.initialize()
    }

    func config(cell: CollectionViewCell, data: Any, indexPath: IndexPath, grid: Grid) {
        guard let data = data as? Data, let cell = cell as? Cell else {
            return
        }

        return self.config(cell: cell, data: data, indexPath: indexPath, grid: grid)
    }

    func size(data: Any, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        guard let data = data as? Data else {
            return .zero
        }

        return self.size(data: data, indexPath: indexPath, grid: grid, view: view)
    }

    func callback(data: Any, indexPath: IndexPath) {
        guard let data = data as? Data else {
            return
        }

        return self.callback(data: data, indexPath: indexPath)
    }

    func initialize() { }

    func config(cell: Cell, data: Data, indexPath: IndexPath, grid: Grid) { }

    func size(data: Data, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        return .zero
    }

    func callback(data: Data, indexPath: IndexPath) { }
}
