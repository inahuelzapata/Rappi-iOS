//
//  AccessTokenResponse.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Tagged

struct AccessTokenResponse {
    typealias AccessToken = Tagged<AccessTokenResponse, String>

    let statusMessage: String
    let requestToken: AccessToken
    let success: Bool
    let statusCode: Int
    let accountId: String
}

extension AccessTokenResponse: Decodable { }
