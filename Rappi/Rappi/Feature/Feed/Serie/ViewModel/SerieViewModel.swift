//
//  SerieViewModel.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

protocol SerieViewModelDelegate: class {
    func didSelect(serie: CategorizedSerie)
}

class SerieViewModel: CollectionViewViewModel<SerieCollectionViewCell, CategorizedSerie> {
    weak var delegate: SerieViewModelDelegate?

    override func config(cell: SerieCollectionViewCell, data: CategorizedSerie, indexPath: IndexPath, grid: Grid) {
        cell.render(basedOn: ShortSerieViewModel(name: data.serie.name,
                                                 imagePath: data.serie.posterPath,
                                                 releaseDate: data.serie.firstAirDate,
                                                 category: data.category))
    }

    override func size(data: CategorizedSerie, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        if grid.columns == 1 {
            return grid.size(for: view, ratio: 1.2)
        }

        if (view.traitCollection.userInterfaceIdiom == .phone &&
                view.traitCollection.verticalSizeClass == .compact) ||
            view.traitCollection.userInterfaceIdiom == .pad {
            return grid.size(for: view, ratio: 1.2, items: 1, gaps: 3)
        }
        return grid.size(for: view, ratio: 1.2, items: 2, gaps: 1)
    }

    override func callback(data: CategorizedSerie, indexPath: IndexPath) {
        self.delegate?.didSelect(serie: data)
    }
}

class HorizontalSerieViewModel: SerieViewModel {
    override func size(data: CategorizedSerie, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        return CGSize(width: 160, height: 258)
    }
}
