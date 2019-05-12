//
//  ResponseParser.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol ResponseParser {
    init(decoder: JSONDecoder)

    func parse<T: Decodable>(response: JSONResponse, expectedType: T.Type,
                             decodingStrategy: JSONDecoder.KeyDecodingStrategy) throws -> T
}
