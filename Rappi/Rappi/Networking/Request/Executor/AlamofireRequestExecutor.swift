//
//  AlamofireRequestExecutor.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

extension Data: JSONResponse { }

class AlamofireRequestExecutor: RequestExecutor, HeaderComposer {
    let responseParser: ResponseParser
    let sessionManager: Alamofire.SessionManager

    required init(responseParser: ResponseParser) {
        self.responseParser = responseParser
        self.sessionManager = .default
    }

    init(responseParser: ResponseParser, sessionManager: Alamofire.SessionManager = .default) {
        self.responseParser = responseParser
        self.sessionManager = sessionManager
    }

    func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse {
        switch request.endpoint.responseType {
        case .stub(let stubType):
            return Promise<T> { seal in
                do {
                    let parsedResponse = try
                    self.responseParser.parse(response: stubType.mockData, expectedType: T.self,
                                              decodingStrategy: request.keyDecodingStrategy)
                    seal.fulfill(parsedResponse)
                } catch {
                    seal.reject(error)
                }
            }

        case .real:
            return Promise<T> { seal in
                sessionManager.request(request.endpoint.builtURL,
                                       method: request.endpoint.httpMethod.method,
                                       parameters: request.params,
                                       encoding: JSONEncoding.default,
                                       headers: compose(headers: request.headers))
                    .validate()
                    .responseJSON { response in
                        do {
                            let parsedResponse = try
                            self.responseParser.parse(response: response, expectedType: T.self,
                                                      decodingStrategy: request.keyDecodingStrategy)
                            seal.fulfill(parsedResponse)
                        } catch {
                            seal.reject(error)
                        }
                }
            }
        }
    }
}
