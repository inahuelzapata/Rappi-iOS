//
//  MovieProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

struct MovieRequest {
    let page: Int
    let apiKey = Environment().configuration(.apiKey)
}

extension MovieRequest: Encodable { }

protocol MovieProvidable: AsyncProvider {
    var endpoint: Endpoint { get }

    var requestBuilder: HTTPRequestBuildeable { get }

    var requestProvider: RequestProvider { get }

    func execute(request: MovieRequest) throws -> Promise<ResponseResult<Movie>>

    func buildRequest(basedOn request: MovieRequest) -> HTTPRequestable
}

extension MovieProvidable {
    func execute(request: MovieRequest) throws -> Promise<ResponseResult<Movie>> {
        return try requestProvider.execute(request: buildRequest(basedOn: request),
                                           expectedModel: ResponseResult<Movie>.self)
    }

    func buildRequest(basedOn request: MovieRequest) -> HTTPRequestable {
        return requestBuilder.consume(endpoint: endpoint)
            .withDecodingStrategy(.convertFromSnakeCase)
            .filter(byParams: request.encodeToDictionary())
            .withEncoding(URLEncoding.default)
            .build()
    }
}

class PopularMovieProvider: MovieProvidable {
    var endpoint: Endpoint { return MovieEndpoint.popular }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }
}

class TopRatedMovieProvider: MovieProvidable {
    var endpoint: Endpoint { return MovieEndpoint.topRated }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }
}

class UpcomingMovieProvider: MovieProvidable {
    var endpoint: Endpoint { return MovieEndpoint.upcoming }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }
}

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
                    let upcomingMovies = $0.2.results.compactMap { CategorizedMovie(movie: $0, category: .upcoming)}

                    seal.resolve(.fulfilled(popularMovies + topRatedMovies + upcomingMovies))
                }.catch { error in
                    seal.reject(error)
            }
        }
    }
}

