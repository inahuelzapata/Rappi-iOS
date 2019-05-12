//
//  Data+EncodeDict.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import os

extension Data {
    func toJSON() -> NSString {
        guard let jsonString = NSString(data: self, encoding: String.Encoding.utf8.rawValue) else {
            os_log(.info, log: .networking, "Can't create NSString with data.")
            return "{ }"
        }

        return jsonString
    }

    func encodeToDict() -> [String: Any] {
        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            as? [String: Any] else {
                return [:]
            }

            return dictionary
        } catch {
            return [:]
        }
    }
}
