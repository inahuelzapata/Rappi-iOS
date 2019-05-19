//
//  TopRatedMovieProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

class TopRatedMovieProvider: MovieProvidable {
    var endpoint: Endpoint { return MovieEndpoint.topRated }

    var requestBuilder: HTTPRequestBuildeable

    var requestProvider: RequestProvider

    required init(requestProvider: RequestProvider, requestBuilder: HTTPRequestBuildeable) {
        self.requestProvider = requestProvider
        self.requestBuilder = requestBuilder
    }
}
