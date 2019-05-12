//
//  HTTPRequestBuilder.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

protocol HTTPRequestBuildeable {
    func build() -> HTTPRequestable

    func consume(endpoint: Endpoint) -> HTTPRequestBuildeable

    func withHeaders(_ headers: [Headable]) -> HTTPRequestBuildeable

    func withDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) -> HTTPRequestBuildeable

    func filter(byParams params: [String: Any]?) -> HTTPRequestBuildeable
}

class HTTPRequestBuilder: HTTPRequestBuildeable {
    private var endpoint: Endpoint!

    private var headers = [Headable]()

    private var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys

    private var params: [String: Any] = [:]

    init() { }

    @discardableResult
    func build() -> HTTPRequestable {
        return HTTPRequest(endpoint: endpoint,
                           headers: headers,
                           decodingStrategy: keyDecodingStrategy,
                           params: params)
    }

    @discardableResult
    func consume(endpoint: Endpoint) -> HTTPRequestBuildeable {
        self.endpoint = endpoint

        return self
    }

    @discardableResult
    func withHeaders(_ headers: [Headable]) -> HTTPRequestBuildeable {
        self.headers = headers

        return self
    }

    @discardableResult
    func withDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) -> HTTPRequestBuildeable {
        self.keyDecodingStrategy = strategy

        return self
    }

    @discardableResult
    func filter(byParams params: [String: Any]?) -> HTTPRequestBuildeable {
        self.params = params ?? [:]

        return self
    }
}
