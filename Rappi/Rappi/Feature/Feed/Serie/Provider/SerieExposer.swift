//
//  SerieExposer.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit

protocol SerieExposer {
    init(popularSerieProvider: SerieProvidable, topRatedSerieProvider: SerieProvidable)

    func expose(popularRequest: SerieRequest, topRatedRequest: SerieRequest) throws -> Promise<[CategorizedSerie]>
}

class SeriesExposer: SerieExposer {
    let popularSerieProvider: SerieProvidable
    let topRatedSerieProvider: SerieProvidable

    required init(popularSerieProvider: SerieProvidable, topRatedSerieProvider: SerieProvidable) {
        self.popularSerieProvider = popularSerieProvider
        self.topRatedSerieProvider = topRatedSerieProvider
    }

    func expose(popularRequest: SerieRequest, topRatedRequest: SerieRequest) throws -> Promise<[CategorizedSerie]> {
        return Promise<[CategorizedSerie]> { seal in
            try when(fulfilled: popularSerieProvider.execute(request: popularRequest),
                     topRatedSerieProvider.execute(request: topRatedRequest))
                .done {
                    let popularSeries = $0.0.results.compactMap { CategorizedSerie(serie: $0, category: .popular) }
                    let topRatedSeries = $0.1.results.compactMap { CategorizedSerie(serie: $0, category: .topRated) }

                    seal.resolve(.fulfilled(popularSeries + topRatedSeries))
                }.catch { error in
                    seal.reject(error)
            }
        }
    }
}
