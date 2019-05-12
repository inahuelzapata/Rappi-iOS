//
//  RequestProvider.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol RequestProvider {
    init(command: RequestExecutor)

    func execute<Output: HTTPResponse, Model: Decodable>(request: HTTPRequestable, expectedModel: Model.Type)
        throws -> Output
}

struct PromiseRequestProvider: RequestProvider {
    let executor: RequestExecutor

    public init(command: RequestExecutor) {
        self.executor = command
    }

    public func execute<Output: HTTPResponse, Model: Decodable>(request: HTTPRequestable, expectedModel: Model.Type)
        throws -> Output {
            guard let promise = executor.execute(request: request, with: Model.self) as? Output else {
                throw NetworkingError.parsing
            }

            return promise
    }
}
