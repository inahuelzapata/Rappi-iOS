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
}

class HTTPRequestBuilder: HTTPRequestBuildeable {
    private var endpoint: Endpoint!

    private var headers = [Headable]()

    private var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys

    init() { }

    @discardableResult
    public func build() -> HTTPRequestable {
        return HTTPRequest(endpoint: endpoint,
                           headers: headers,
                           decodingStrategy: keyDecodingStrategy)
    }

    @discardableResult
    public func consume(endpoint: Endpoint) -> HTTPRequestBuildeable {
        self.endpoint = endpoint

        return self
    }

    @discardableResult
    public func withHeaders(_ headers: [Headable]) -> HTTPRequestBuildeable {
        self.headers = headers

        return self
    }

    @discardableResult
    public func withDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) -> HTTPRequestBuildeable {
        self.keyDecodingStrategy = strategy

        return self
    }
}
