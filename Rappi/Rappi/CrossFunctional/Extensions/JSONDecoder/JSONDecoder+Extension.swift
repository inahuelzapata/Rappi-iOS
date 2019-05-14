//
//  JSONDecoder+Extension.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type,
                              withJSONObject object: Any,
                              options opt: JSONSerialization.WritingOptions = .prettyPrinted) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)

        return try decode(T.self, from: data)
    }
}
