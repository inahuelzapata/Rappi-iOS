//
//  AccessTokenRequest.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct AccessTokenRequest {
    let requestToken: String
}

extension AccessTokenRequest: Encodable { }
