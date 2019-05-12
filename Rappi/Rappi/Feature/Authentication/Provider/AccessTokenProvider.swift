//
//  AccessTokenProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit

protocol AccessTokenProvidable: AsyncProvider {
    func execute(request: AccessTokenRequest) throws -> Promise<AccessTokenResponse>

    func buildRequest(basedOn request: AccessTokenRequest) -> HTTPRequestable
}

class AccessTokenProvider: AccessTokenProvidable {
    let requestProvider: RequestProvider
    let requestBuilder: HTTPRequestBuildeable

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }

    func execute(request: AccessTokenRequest) throws -> Promise<AccessTokenResponse> {
        return try requestProvider.execute(request: buildRequest(basedOn: request),
                                           expectedModel: AccessTokenResponse.self)
    }

    func buildRequest(basedOn request: AccessTokenRequest) -> HTTPRequestable {
        return requestBuilder.consume(endpoint: AuthenticationEndpoint.accessToken)
            .withDecodingStrategy(.convertFromSnakeCase)
            .withHeaders([Header.contentType(type: .applicationJSON),
                          Header.authorization(token: Environment().configuration(.accessToken))])
            .filter(byParams: request.encodeToDictionary())
            .build()
    }
}
