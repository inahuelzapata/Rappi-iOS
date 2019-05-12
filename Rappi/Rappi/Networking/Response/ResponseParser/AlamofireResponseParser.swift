//
//  AlamofireResponseParser.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

class AlamofireResponseParser: ResponseParser {
    let decoder: JSONDecoder

    required init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func parse<T: Decodable>(response: JSONResponse, expectedType: T.Type,
                             decodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        setKeyDecodingStrategy(decodingStrategy)

        guard let responseData = response as? DataResponse<Any> else {
            throw CommonError.casting
        }

        switch responseData.result {
        case .success(let value):
            do {
                let decodedValue = try decoder.decode(T.self, withJSONObject: value)

                return decodedValue
            } catch {
                throw NetworkingError.invalidJSON
            }

        case .failure:
            guard let data = responseData.data else {
                throw NetworkingError.unwrap
            }

            guard let errorData = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                throw NetworkingError.parsing
            }

            guard let statusCode = responseData.response?.statusCode else {
                throw NetworkingError.unwrap
            }

            throw NetworkingError.backend(statusCode: statusCode, model: errorData)
        }
    }

    private func setKeyDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) {
        self.decoder.keyDecodingStrategy = strategy
    }
}
