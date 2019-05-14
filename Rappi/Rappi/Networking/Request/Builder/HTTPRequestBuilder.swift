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

    func withEncoding(_ encoding: ParameterEncoding) -> HTTPRequestBuildeable
}

class HTTPRequestBuilder: HTTPRequestBuildeable {
    private var endpoint: Endpoint!

    private var headers: [Headable] = [Headable]()

    private var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys

    private var params: [String: Any]?

    private var encoding: ParameterEncoding = JSONEncoding.default

    init() { }

    @discardableResult
    func build() -> HTTPRequestable {
        defer {
            resetToDefault()
        }

        return HTTPRequest(endpoint: endpoint,
                           headers: headers,
                           decodingStrategy: keyDecodingStrategy,
                           params: params,
                           encoding: encoding)
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

    @discardableResult
    func withEncoding(_ encoding: ParameterEncoding) -> HTTPRequestBuildeable {
        self.encoding = encoding

        return self
    }

    func resetToDefault() {
        self.params = nil
        self.headers = []
        self.keyDecodingStrategy = .useDefaultKeys
        self.encoding = JSONEncoding.default
    }
}
