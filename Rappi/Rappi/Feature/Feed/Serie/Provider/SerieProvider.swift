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
