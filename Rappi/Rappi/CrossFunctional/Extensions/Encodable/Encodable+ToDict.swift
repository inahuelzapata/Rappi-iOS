//
//  Encodable+ToDict.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

extension Encodable {
    func encodeToDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder.snakeCaseDecoder.encode(self)

            guard let result = try JSONSerialization.jsonObject(with: data,
                                                                options: .allowFragments) as? [String: Any] else {
                throw CommonError.encoding
            }

            return !result.isEmpty ? result : nil
        } catch {
            return nil
        }
    }
}

extension JSONEncoder {
    static let snakeCaseDecoder: JSONEncoder = {
        let encoder = JSONEncoder()

        encoder.keyEncodingStrategy = .convertToSnakeCase

        return encoder
    }()
}
