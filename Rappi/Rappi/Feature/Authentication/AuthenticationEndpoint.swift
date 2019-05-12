//
//  AuthenticationEndpoint.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

enum AuthenticationEndpoint: Endpoint {
    case accessToken
    case requestToken

    var httpMethod: HTTPSMethod {
        switch self {
        case .accessToken:
            return .post

        case .requestToken:
            return .post
        }
    }

    var path: String {
        switch self {
        case .accessToken:
            return "/auth/access_token"

        case .requestToken:
            return "/auth/request_token"
        }
    }
}
