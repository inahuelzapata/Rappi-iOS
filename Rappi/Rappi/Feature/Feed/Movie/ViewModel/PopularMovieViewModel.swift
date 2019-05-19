//
//  PopularMovieViewModel.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

protocol PopularMovieViewModelDelegate: class {
    func didSelect(movie: CategorizedMovie)
}

class PopularMovieViewModel: CollectionViewViewModel<MovieCollectionViewCell, CategorizedMovie> {
    weak var delegate: PopularMovieViewModelDelegate?

    override func config(cell: MovieCollectionViewCell, data: CategorizedMovie, indexPath: IndexPath, grid: Grid) {
        cell.render(from: ShortMovieViewModel(title: data.movie.title,
                                              imagePath: data.movie.posterPath ?? String(),
                                              rating: data.movie.popularity,
                                              category: data.category))
    }

    override func size(data: CategorizedMovie, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
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

    override func callback(data: CategorizedMovie, indexPath: IndexPath) {
        self.delegate?.didSelect(movie: data)
    }
}

class HorizontalMovieViewModel: PopularMovieViewModel {
    override func size(data: CategorizedMovie, indexPath: IndexPath, grid: Grid, view: UIView) -> CGSize {
        return CGSize(width: 140, height: 164)
    }
}
