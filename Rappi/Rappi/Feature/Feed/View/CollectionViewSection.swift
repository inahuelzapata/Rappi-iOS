//
//  CollectionViewSection.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

class CollectionViewSection {
    var grid: Grid?
    var header: CollectionViewViewModelProtocol?
    var footer: CollectionViewViewModelProtocol?
    var items: [CollectionViewViewModelProtocol]
    var callback: CollectionViewCallback?

    init(grid: Grid? = nil,
         header: CollectionViewViewModelProtocol? = nil,
         footer: CollectionViewViewModelProtocol? = nil,
         items: [CollectionViewViewModelProtocol] = [],
         callback: CollectionViewCallback? = nil) {
        self.grid = grid
        self.header = header
        self.footer = footer
        self.items = items
        self.callback = callback
    }

    func add(_ item: CollectionViewViewModelProtocol) {
        self.items.append(item)
    }
}
