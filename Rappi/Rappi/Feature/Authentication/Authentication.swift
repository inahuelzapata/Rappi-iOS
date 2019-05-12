//
//  AuthorizationResponse.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Tagged

struct Authentication {
    typealias RequestToken = Tagged<Authentication, String>

    let statusMessage: String
    let requestToken: RequestToken
    let success: Bool
    let statusCode: Int
}

extension Authentication: Decodable { }
