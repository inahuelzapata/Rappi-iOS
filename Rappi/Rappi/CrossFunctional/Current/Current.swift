//
//  Current.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

// Inspired in this conf talk
// https://vimeo.com/291588126
// by Stephen Celis

struct CurrentEnvironment {
    let responseParser: ResponseParser
    let requestExecutor: RequestExecutor
    let requestProvider: RequestProvider
    let requestBuilder: HTTPRequestBuildeable
}

let current: CurrentEnvironment = {
    let responseParser: ResponseParser = AlamofireResponseParser(decoder: JSONDecoder())
    let requestExecutor: RequestExecutor = AlamofireRequestExecutor(responseParser: responseParser)
    let requestProvider: RequestProvider = PromiseRequestProvider(command: requestExecutor)
    let requestBuilder: HTTPRequestBuildeable = HTTPRequestBuilder()

    return CurrentEnvironment(responseParser: responseParser,
                              requestExecutor: requestExecutor,
                              requestProvider: requestProvider,
                              requestBuilder: requestBuilder)
}()
