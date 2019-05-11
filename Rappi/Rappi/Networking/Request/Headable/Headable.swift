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
}

extension Header: Headable {
    var value: [String: String] {
        switch self {
        case .contentType(let type):
            return ["Content-Type": type.value]

        case .authentication(let token):
            return ["Authentication": token]
        }
    }
}

enum ContentType: String {
    case applicationJson
    case imagePng
    case imageJpeg
    case textPlain

    var value: String {
        switch self {
        case .applicationJson:
            return "application/json"
        case .imagePng:
            return "image/png"
        case .imageJpeg:
            return "image/jpeg"
        case .textPlain:
            return "text/plain"
        }
    }
}
