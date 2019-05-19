//
//  SerieViewControlle.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import SkeletonView
import UIKit

class SerieViewController: CollectionViewController {
    let seriesExposer: SerieExposer =
        SeriesExposer(popularSerieProvider: PopularSerieProvider(requestProvider: current.requestProvider,
                                                                 requestBuilder: current.requestBuilder),
                      topRatedSerieProvider: TopRatedSerieProvider(requestProvider: current.requestProvider,
                                                                   requestBuilder: current.requestBuilder))

    var series: [CategorizedSerie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        retrieveCategorizedSeries()
        renderGrid()
    }

    func retrieveCategorizedSeries() {
        view.showAnimatedGradientSkeleton()
        do {
            try seriesExposer.expose(popularRequest: SerieRequest(page: 1), topRatedRequest: SerieRequest(page: 1))
                .done { [weak self] series in
                    self?.series = series
                    self?.renderGrid()
                    self?.view.hideSkeleton()
                }.cauterize()
        } catch {
            print("❌")
            view.hideSkeleton()
        }
    }

    func renderGrid() {
        let grid = Grid(columns: 2, margin: UIEdgeInsets(all: 5))

        let popularSection = CollectionViewSection(items: [createHorizontal(basedOn: series, category: .popular)])
        popularSection.header = HeaderViewModel(CategorizedMovie.Category.popular.title)

        let topRatedSection = CollectionViewSection(items: [createHorizontal(basedOn: series, category: .topRated)])
        topRatedSection.header = HeaderViewModel(CategorizedMovie.Category.topRated.title)

        self.source = CollectionViewSource(grid: grid, sections: [popularSection, topRatedSection])
        self.collectionView.reloadData()
    }

    func createHorizontal(basedOn series: [CategorizedSerie],
                          category: CategorizedSerie.Category) -> SerieCollectionViewModel {
        let items = series
            .filter { $0.category == category }
            .map { serie -> HorizontalSerieViewModel in
                let viewModel = HorizontalSerieViewModel(serie)

                viewModel.delegate = self

                return viewModel
        }

        let grid = Grid(columns: 2, margin: UIEdgeInsets(all: 8))
        let section = CollectionViewSection(items: items)
        let source = CollectionViewSource(grid: grid, sections: [section])

        return SerieCollectionViewModel(source)
    }
}

extension SerieViewController: LargeTitlesNavigation { }

extension SerieViewController: SerieViewModelDelegate {
    func didSelect(serie: CategorizedSerie) {
        // Skere
    }
}
