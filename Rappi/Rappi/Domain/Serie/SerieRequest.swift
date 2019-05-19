//
//  SerieRequest.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct SerieRequest {
    let page: Int
    let apiKey = Environment().configuration(.apiKey)
}

extension SerieRequest: Encodable { }
