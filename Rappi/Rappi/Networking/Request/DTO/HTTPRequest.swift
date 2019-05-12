//
//  HTTPRequest.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

struct HTTPRequest: HTTPRequestable {
    var endpoint: Endpoint

    var headers: [Headable]

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy

    var params: [String: Any]?

    init(endpoint: Endpoint,
         headers: [Headable],
         decodingStrategy: JSONDecoder.KeyDecodingStrategy,
         params: [String: Any]? = nil) {
        self.endpoint = endpoint
        self.headers = headers
        self.keyDecodingStrategy = decodingStrategy
        self.params = params
    }
}
