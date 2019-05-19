//
//  MovieExposer.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit

protocol MovieExposer {
    init(popularProvider: MovieProvidable, topRatedProvider: MovieProvidable, upcomingProvider: MovieProvidable)

    func expose(popularRequest: MovieRequest,
                topRatedRequest: MovieRequest,
                upcomingRequest: MovieRequest) throws -> Promise<[CategorizedMovie]>
}

class MoviesExposer: MovieExposer {
    let popularProvider: MovieProvidable
    let topRatedProvider: MovieProvidable
    let upcomingProvider: MovieProvidable

    required init(popularProvider: MovieProvidable,
                  topRatedProvider: MovieProvidable,
                  upcomingProvider: MovieProvidable) {
        self.popularProvider = popularProvider
        self.topRatedProvider = topRatedProvider
        self.upcomingProvider = upcomingProvider
    }

    func expose(popularRequest: MovieRequest,
                topRatedRequest: MovieRequest,
                upcomingRequest: MovieRequest) throws -> Promise<[CategorizedMovie]> {
        return Promise<[CategorizedMovie]> { seal in
            try when(fulfilled: popularProvider.execute(request: popularRequest),
                     topRatedProvider.execute(request: topRatedRequest),
                     upcomingProvider.execute(request: upcomingRequest))
                .done {
                    let popularMovies = $0.0.results.compactMap { CategorizedMovie(movie: $0, category: .popular) }
                    let topRatedMovies = $0.1.results.compactMap { CategorizedMovie(movie: $0, category: .topRated) }
                    let upcomingMovies = $0.2.results.compactMap { CategorizedMovie(movie: $0, category: .upcoming) }

                    seal.resolve(.fulfilled(popularMovies + topRatedMovies + upcomingMovies))
                }.catch { error in
                    seal.reject(error)
            }
        }
    }
}
