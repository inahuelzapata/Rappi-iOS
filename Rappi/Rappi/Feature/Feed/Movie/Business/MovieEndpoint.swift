//
//  MovieEndpoint.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

enum MovieEndpoint: Endpoint {
    case popular

    var httpMethod: HTTPSMethod {
        switch self {
        case .popular:
            return .get
        }
    }

    var path: String {
        switch self {
        case .popular:
            return "/discover/movie"
        }
    }
}
