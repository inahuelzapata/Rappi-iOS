//
//  HeaderComposer.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol HeaderComposer {
    func compose(headers: [Headable]) -> [String: String]
}

extension HeaderComposer {
    func compose(headers: [Headable]) -> [String: String] {
        let flattenHeaders = headers.map { return $0.value }
            .flatMap { $0 }
            .reduce([String: String]()) {
                var nextDict = $0
                nextDict.updateValue($1.1, forKey: $1.0)

                return nextDict
        }

        return flattenHeaders
    }
}
