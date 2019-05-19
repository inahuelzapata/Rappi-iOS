//
//  FeedViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit
import SkeletonView
import UIKit

struct MovieDataStorage: DataStorage {
    let accountID: String
}

class MovieViewController: CollectionViewController {
    let moviesExposer: MovieExposer =
        MoviesExposer(popularProvider: PopularMovieProvider(requestProvider: current.requestProvider,
                                                            requestBuilder: current.requestBuilder),
                      topRatedProvider: TopRatedMovieProvider(requestProvider: current.requestProvider,
                                                              requestBuilder: current.requestBuilder),
                      upcomingProvider: UpcomingMovieProvider(requestProvider: current.requestProvider,
                                                              requestBuilder: current.requestBuilder))

    var movies: [CategorizedMovie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        retrieveMovies()
        renderGrid()
    }

    func retrieveMovies() {
        view.showAnimatedGradientSkeleton()

        do {
            try moviesExposer.expose(popularRequest: MovieRequest(page: 1),
                                     topRatedRequest: MovieRequest(page: 1),
                                     upcomingRequest: MovieRequest(page: 1))
                .done { [weak self] movies in
                    self?.movies = movies
                    self?.renderGrid()
                    self?.view.hideSkeleton()
                }.cauterize()
        } catch {
            print("❌")
            self.view.hideSkeleton()
        }
    }

    func renderGrid() {
        let grid = Grid(columns: 2, margin: UIEdgeInsets(all: 5))

        let popularSection = CollectionViewSection(items: [createHorizontal(basedOn: movies, category: .popular)])
        popularSection.header = HeaderViewModel(CategorizedMovie.Category.popular.title)

        let topRatedSection = CollectionViewSection(items: [createHorizontal(basedOn: movies, category: .topRated)])
        topRatedSection.header = HeaderViewModel(CategorizedMovie.Category.topRated.title)

        let upcomingSection = CollectionViewSection(items: [createHorizontal(basedOn: movies, category: .upcoming)])
        upcomingSection.header = HeaderViewModel(CategorizedMovie.Category.upcoming.title)

        self.source = CollectionViewSource(grid: grid, sections: [popularSection, topRatedSection, upcomingSection])
        self.collectionView.reloadData()
    }

    func createHorizontal(basedOn movies: [CategorizedMovie],
                          category: CategorizedMovie.Category) -> CollectionViewModel {
        let items = movies
            .filter { $0.category == category }
            .map { popular -> HorizontalMovieViewModel in
            let viewModel = HorizontalMovieViewModel(popular)

            viewModel.delegate = self

            return viewModel
        }

        let grid = Grid(columns: 2, margin: UIEdgeInsets(all: 8))
        let section = CollectionViewSection(items: items)
        let source = CollectionViewSource(grid: grid, sections: [section])

        return CollectionViewModel(source)
    }
}

extension MovieViewController: LargeTitlesNavigation { }

extension MovieViewController: PopularMovieViewModelDelegate {
    func didSelect(movie: CategorizedMovie) {
        // SKERE
    }
}
