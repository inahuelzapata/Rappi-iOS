//
//  SerieEndpoint.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/13/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

enum SerieEndpoint: Endpoint {
    case popular
    case topRated

    var httpMethod: HTTPSMethod {
        switch self {
        case .popular:
            return .get

        case .topRated:
            return .get
        }
    }

    var path: String {
        switch self {
        case .popular:
            return "/tv/popular"
        case .topRated:
            return "/tv/top_rated"
        }
    }

    var baseURL: String {
        return Environment().configuration(.serverURLv3)
    }
}
