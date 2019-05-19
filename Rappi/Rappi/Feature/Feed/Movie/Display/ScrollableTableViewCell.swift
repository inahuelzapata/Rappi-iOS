//
//  ScrollableTableViewCell.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class ScrollableTableViewCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.registerReusableNibCell(MovieCollectionViewCell.self,
                                               forBundle: Bundle(for: MovieCollectionViewCell.self))
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 180, height: 180)
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }

    func setCollectionView(dataSource: UICollectionViewDataSource,
                           delegate: UICollectionViewDelegate,
                           indexPath: IndexPath) {
        if collectionView.dataSource == nil {
            collectionView.dataSource = dataSource
        }

        if collectionView.delegate == nil {
            collectionView.delegate = delegate
        }

        collectionView.reloadData()
    }
}

extension ScrollableTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 64)
    }
}
