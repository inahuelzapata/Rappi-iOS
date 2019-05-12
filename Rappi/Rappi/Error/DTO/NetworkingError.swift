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
}
