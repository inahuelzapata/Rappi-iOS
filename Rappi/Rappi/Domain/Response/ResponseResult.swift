//
//  ResponseResult.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct ResponseResult<T: Decodable> {
    let page: Int
    let results: [T]
    let totalResults: Int
    let totalPages: Int
}

extension ResponseResult: Decodable { }
