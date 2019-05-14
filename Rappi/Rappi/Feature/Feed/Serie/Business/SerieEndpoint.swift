//
//  SerieEndpoint.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/13/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

enum SerieEndpoint: Endpoint {
    case discover

    var httpMethod: HTTPSMethod {
        switch self {
        case .discover:
            return .get
        }
    }

    var path: String {
        switch self {
        case .discover:
            return "/tv/popular"
        }
    }
}
