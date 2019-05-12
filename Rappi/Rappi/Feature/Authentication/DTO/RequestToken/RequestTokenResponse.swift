//
//  RequestTokenResponse.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Tagged

struct RequestTokenResponse {
    typealias RequestToken = Tagged<RequestTokenResponse, String>

    let statusMessage: String
    let requestToken: RequestToken
    let success: Bool
    let statusCode: Int
}

extension RequestTokenResponse: Decodable { }
