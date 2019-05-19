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
