//
//  Headable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol Headable {
    var value: [String: String] { get }
}

enum Header {
    case contentType(type: ContentType)
    case authentication(token: String)
    case authorization(token: String)
    case apiKey(apiKey: String)
}

extension Header: Headable {
    var value: [String: String] {
        switch self {
        case .contentType(let type):
            return ["Content-Type": type.value]

        case .authentication(let token):
            return ["Authentication": token]

        case .authorization(let token):
            return ["Authorization": "Bearer \(token)"]

        case .apiKey(let apiKey):
            return ["api_key": apiKey]
        }
    }
}
