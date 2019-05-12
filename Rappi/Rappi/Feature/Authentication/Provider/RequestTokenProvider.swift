//
//  AuthenticationProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit

protocol AsyncProvider {
    init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable)
}

protocol RequestTokenProvidable: AsyncProvider {
    func execute(request: RequestTokenRequest) throws -> Promise<RequestTokenResponse>

    func buildRequest(basedOn request: RequestTokenRequest) -> HTTPRequestable
}

class RequestTokenProvider: RequestTokenProvidable {
    let requestProvider: RequestProvider
    let requestBuilder: HTTPRequestBuildeable

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }

    func execute(request: RequestTokenRequest) throws -> Promise<RequestTokenResponse> {
        return try requestProvider.execute(request: buildRequest(basedOn: request),
                                           expectedModel: RequestTokenResponse.self)
    }

    func buildRequest(basedOn request: RequestTokenRequest) -> HTTPRequestable {
        return requestBuilder.consume(endpoint: AuthenticationEndpoint.requestToken)
            .withDecodingStrategy(.convertFromSnakeCase)
            .withHeaders([Header.contentType(type: .applicationJSON),
                          Header.authorization(token: Environment().configuration(.accessToken))])
            .build()
    }
}
