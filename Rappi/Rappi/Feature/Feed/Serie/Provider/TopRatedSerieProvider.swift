//
//  TopRatedSerieProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

class TopRatedSerieProvider: SerieProvidable {
    var endpoint: Endpoint {
        return SerieEndpoint.topRated
    }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestBuilder = requestBuilder
        self.requestProvider = requestProvider
    }
}
