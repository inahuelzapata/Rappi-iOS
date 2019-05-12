//
//  HTTPMethodAdapter.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

protocol HTTPMethodAdapter {
    var method: Alamofire.HTTPMethod { get }
}

enum HTTPSMethod: HTTPMethodAdapter {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect

    public var method: Alamofire.HTTPMethod {
        switch self {
        case .options:
            return .options

        case .get:
            return .get

        case .head:
            return .head

        case .post:
            return .post

        case .put:
            return .put

        case .patch:
            return .patch

        case .delete:
            return .delete

        case .trace:
            return .trace

        case .connect:
            return .connect
        }
    }
}
