//
//  RequestExecutor.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

protocol RequestExecutor {
    init(parser: ResponseParser)

    func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse
}
