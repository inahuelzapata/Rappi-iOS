//
//  ContentType.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

enum ContentType: String {
    case applicationJSON
    case imagePng
    case imageJpeg
    case textPlain

    var value: String {
        switch self {
        case .applicationJSON:
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
