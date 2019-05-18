//
//  SerieProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/13/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

struct SerieRequest {
    let page: Int
    let apiKey = Environment().configuration(.apiKey)
}

extension SerieRequest: Encodable { }

protocol SerieProvidable: AsyncProvider {
    var endpoint: Endpoint { get }

    var requestBuilder: HTTPRequestBuildeable { get }

    var requestProvider: RequestProvider { get }

    func execute(request: SerieRequest) throws -> Promise<ResponseResult<Serie>>

    func buildRequest(basedOn request: SerieRequest) -> HTTPRequestable
}

extension SerieProvidable {
    func execute(request: SerieRequest) throws -> Promise<ResponseResult<Serie>> {
        return try requestProvider.execute(request: buildRequest(basedOn: request),
                                           expectedModel: ResponseResult<Serie>.self)
    }

    func buildRequest(basedOn request: SerieRequest) -> HTTPRequestable {
        return requestBuilder.consume(endpoint: endpoint)
            .filter(byParams: request.encodeToDictionary())
            .withDecodingStrategy(.convertFromSnakeCase)
            .withEncoding(URLEncoding.default)
            .build()
    }
}

class PopularSerieProvider: SerieProvidable {
    var endpoint: Endpoint {
        return SerieEndpoint.popular
    }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestBuilder = requestBuilder
        self.requestProvider = requestProvider
    }
}

class TopRatedSerieProvider: SerieProvidable {
    var endpoint: Endpoint {
        return SerieEndpoint.topRated
    }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestBuilder = requestBuilder
        self.requestProvider = requestProvider
    }
}

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
