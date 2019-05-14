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
    case topRated
    case upcoming

    var httpMethod: HTTPSMethod {
        switch self {
        case .popular:
            return .get

        case .topRated:
            return .get

        case .upcoming:
            return .get
        }
    }

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular" // ?\(apiKeyPath)&page=\(page)"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }

    var baseURL: String {
        return Environment().configuration(.serverURLv3)
    }
}
