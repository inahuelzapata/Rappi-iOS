//
//  CollectionViewModel.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewModel: CollectionViewViewModel<CollectionCell, CollectionViewSource> {
    override func config(cell: CollectionCell, data: CollectionViewSource, indexPath: IndexPath, grid: Grid) {
        cell.source = data
    }

    override func size(data: CollectionViewSource, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        return grid.size(for: view, height: 180, items: grid.columns)
    }
}

class SerieCollectionViewModel: CollectionViewViewModel<CollectionCell, CollectionViewSource> {
    override func config(cell: CollectionCell, data: CollectionViewSource, indexPath: IndexPath, grid: Grid) {
        cell.source = data
    }

    override func size(data: CollectionViewSource, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        return grid.size(for: view, height: 257, items: grid.columns)
    }
}
