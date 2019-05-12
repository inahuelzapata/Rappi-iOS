//
//  Endpoint.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol Endpoint {
    var httpMethod: HTTPSMethod { get }

    var path: String { get }

    var baseURL: String { get }

    var builtURL: String { get }

    var responseType: ResponseType { get }
}

enum ResponseType {
    case stub(Mockable)
    case real
}

extension Endpoint {
    var builtURL: String {
        return baseURL + path
    }

    var baseURL: String {
        return Environment().configuration(.serverURL)
    }

    var responseType: ResponseType {
        return .real
    }
}
