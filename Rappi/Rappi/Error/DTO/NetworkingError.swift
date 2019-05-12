//
//  NetworkingError.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case invalidJSON
    case unwrap
    case parsing
    case backend(statusCode: Int, model: [String: Any])
    case statusCode(Int)
}

extension NetworkingError {
    var content: [String: Any] {
        if case let .backend(_, dict) = self {
            return dict
        }

        return [:]
    }

    var statusCode: Int {
        switch self {
        case .statusCode(let statusCode):
            return statusCode

        case .backend(let statusCode, _):
            return statusCode

        default:
            return 601
        }
    }
}
