//
//  Endpoint.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

protocol Endpoint {
    var httpMethod: HTTPMethod { get }

    var path: String { get }

    var baseURL: String { get }

    var builtURL: String { get }
}

extension Endpoint {
    var buildURL: String {
        return baseURL + path
    }
}
