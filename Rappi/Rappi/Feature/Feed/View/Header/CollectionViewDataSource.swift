//
//  CollectionViewDataSource.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewSource: NSObject {
    private var indexPathSelected = false

    var grid: Grid
    var sections: [CollectionViewSection]
    var callback: CollectionViewCallback?

    init(grid: Grid = Grid(),
         sections: [CollectionViewSection] = [],
         callback: CollectionViewCallback? = nil) {
        self.grid = grid
        self.sections = sections
        self.callback = callback

        super.init()
    }

    func add(_ section: CollectionViewSection) {
        self.sections.append(section)
    }

    // MARK: - section indexes

    var sectionIndexes: IndexSet? {
        if self.sections.isEmpty {
            return nil
        }
        if self.sections.count == 1 {
            return IndexSet(integer: 0)
        }
        return IndexSet(integersIn: 0..<self.sections.count - 1)
    }

    // MARK: - item helpers

    func itemAt(_ section: Int) -> CollectionViewSection? {
        return self.sections.element(at: section)
    }

    func itemAt(_ indexPath: IndexPath) -> CollectionViewViewModelProtocol? {
        return self.itemAt(indexPath.section)?.items.element(at: indexPath.item)
    }

    // MARK: - view registration

    func register(itemsFor collectionView: UICollectionView) {
        for section in self.sections {
            section.header?.cell.register(itemFor: collectionView, kind: UICollectionView.elementKindSectionHeader)
            section.footer?.cell.register(itemFor: collectionView, kind: UICollectionView.elementKindSectionFooter)

            for cell in section.items.map({ $0.cell }) {
                cell.register(itemFor: collectionView)
            }
        }
    }
}

extension CollectionViewSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemAt(section)?.items.count ?? 0
    }

    private func collectionView(_ collectionView: UICollectionView,
                                itemForIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let data = self.itemAt(indexPath),
            let item = data.cell.reuse(collectionView, indexPath: indexPath) as? CollectionViewCell
            else {
                return CollectionViewCell.reuse(collectionView, indexPath: indexPath)
        }
        data.config(cell: item, data: data.value, indexPath: indexPath, grid: self.grid(indexPath.section))
        return item
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView(collectionView, itemForIndexPath: indexPath)
    }

    private func _collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let grid = self.grid(indexPath.section)
        let section = self.itemAt(indexPath.section)

        if kind == UICollectionView.elementKindSectionHeader {
            guard
                let section = section,
                let data = section.header,
                let cell = data.cell.reuse(collectionView,
                                           indexPath: indexPath,
                                           kind: UICollectionView.elementKindSectionHeader) as? CollectionViewCell
                else {
                    return CollectionViewCell.reuse(collectionView, indexPath: indexPath)
            }
            data.config(cell: cell, data: data.value, indexPath: indexPath, grid: grid)
            return cell
        }

        if kind == UICollectionView.elementKindSectionFooter {
            guard
                let section = section,
                let data = section.footer,
                let cell = data.cell.reuse(collectionView,
                                           indexPath: indexPath,
                                           kind: UICollectionView.elementKindSectionFooter) as? CollectionViewCell
                else {
                    return CollectionViewCell.reuse(collectionView, indexPath: indexPath)
            }
            data.config(cell: cell, data: data.value, indexPath: indexPath, grid: grid)
            return cell
        }

        return CollectionViewCell.reuse(collectionView,
                                        indexPath: indexPath,
                                        kind: UICollectionView.elementKindSectionHeader)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return self._collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
    }
}

extension CollectionViewSource: UICollectionViewDelegate {
    func selectItem(at indexPath: IndexPath) {
        guard let data = self.itemAt(indexPath), !self.indexPathSelected else {
            return
        }

        //source
        self.callback?(data.value, indexPath)
        //section
        self.itemAt(indexPath.section)?.callback?(data.value, indexPath)
        //view-model
        data.callback(data: data.value, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.selectItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) { }
}

extension CollectionViewSource: UICollectionViewDelegateFlowLayout {
    func grid(_ section: Int) -> Grid {
        return self.itemAt(section)?.grid ?? self.grid
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let data = self.itemAt(indexPath) else {
            return .zero
        }
        let grid = self.grid(indexPath.section)

        return data.size(data: data.value, indexPath: indexPath, grid: grid, view: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.grid(section).margin
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.grid(section).verticalPadding
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.grid(section).horizontalPadding
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let data = self.itemAt(section)?.header else {
            return .zero
        }
        let indexPath = IndexPath(item: -1, section: section)
        let grid = self.grid(section)
        return data.size(data: data.value, indexPath: indexPath, grid: grid, view: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let data = self.itemAt(section)?.footer else {
            return .zero
        }
        let indexPath = IndexPath(item: -1, section: section)
        let grid = self.grid(section)
        return data.size(data: data.value, indexPath: indexPath, grid: grid, view: collectionView)
    }
}
