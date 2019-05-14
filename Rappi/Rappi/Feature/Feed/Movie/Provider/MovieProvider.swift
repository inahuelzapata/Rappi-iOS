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
    func execute(request: MovieRequest) throws -> Promise<ResponseResult<Movie>>

    func buildRequest(basedOn request: MovieRequest) -> HTTPRequestable
}

class MovieProvider: MovieProvidable {
    let requestProvider: RequestProvider
    let requestBuilder: HTTPRequestBuildeable

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestBuilder = requestBuilder
        self.requestProvider = requestProvider
    }

    func execute(request: MovieRequest) throws -> Promise<ResponseResult<Movie>> {
        return try requestProvider.execute(request: buildRequest(basedOn: request),
                                           expectedModel: ResponseResult<Movie>.self)
    }

    func buildRequest(basedOn request: MovieRequest) -> HTTPRequestable {
        return requestBuilder.consume(endpoint: MovieEndpoint.popular)
            .withDecodingStrategy(.convertFromSnakeCase)
            .filter(byParams: request.encodeToDictionary())
            .withEncoding(URLEncoding.default)
            .build()
    }
}
