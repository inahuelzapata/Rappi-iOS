//
//  HTTPRequestable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

protocol HTTPRequestable {
    var endpoint: Endpoint { get set }

    var headers: [Headable] { get set }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get set }

    var params: [String: Any]? { get set }

    var encoding: ParameterEncoding { get set }
}
