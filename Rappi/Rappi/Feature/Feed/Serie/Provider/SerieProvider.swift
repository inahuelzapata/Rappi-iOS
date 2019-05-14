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
    func execute(request: SerieRequest) throws -> Promise<ResponseResult<Serie>>

    func buildRequest(basedOn request: SerieRequest) -> HTTPRequestable
}

class SerieProvider: SerieProvidable {
    let requestProvider: RequestProvider
    let requestBuilder: HTTPRequestBuildeable

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestBuilder = requestBuilder
        self.requestProvider = requestProvider
    }

    func execute(request: SerieRequest) throws -> Promise<ResponseResult<Serie>> {
        return try requestProvider.execute(request: buildRequest(basedOn: request),
                                           expectedModel: ResponseResult<Serie>.self)
    }

    func buildRequest(basedOn request: SerieRequest) -> HTTPRequestable {
        return requestBuilder.consume(endpoint: SerieEndpoint.popular)
            .filter(byParams: request.encodeToDictionary())
            .withDecodingStrategy(.convertFromSnakeCase)
            .withEncoding(URLEncoding.default)
            .build()
    }
}
