//
//  AuthenticationProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit

protocol AuthenticationProvidable {
    init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable)

    func execute(request: [String: Any]) throws -> Promise<Authentication>

    func buildRequest() -> HTTPRequestable
}

class AuthenticationProvider: AuthenticationProvidable {
    let requestProvider: RequestProvider
    let requestBuilder: HTTPRequestBuildeable

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }

    func execute(request: [String: Any]) throws -> Promise<Authentication> {
        return try requestProvider.execute(request: buildRequest(), expectedModel: Authentication.self)
    }

    func buildRequest() -> HTTPRequestable {
        return requestBuilder.consume(endpoint: AuthenticationEndpoint.requestToken)
            .withDecodingStrategy(.convertFromSnakeCase)
            .withHeaders([])
            .build()
    }
}
