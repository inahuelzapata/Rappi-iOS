//
//  Collection+Extension.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

extension Collection {
    /// Convert self to NSString.
    /// - Parameters: an array of WritingOptions. By default will use .prettyPrinted.
    /// - Returns: Returns the JSON as NSString or empty string if error while parsing.
    func dictToJSON(writingOptions: JSONSerialization.WritingOptions = [.prettyPrinted]) -> NSString {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: writingOptions)

            guard let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) else {
                print("❌ Can't create string with data.")
                return "{ }"
            }

            return jsonString
        } catch {
            print("❌ Error while parsing: \(error)")

            return "{ }"
        }
    }
}

extension Data {
    func toJSON() -> NSString {
        do {
            if let jsonData = try JSONSerialization.jsonObject(with: self,
                                                               options: [.allowFragments]) as? [String: Any] {
                return jsonData.dictToJSON()
            }
            print("❌ Error while casting")
            return "{ }"
        } catch {
            print("❌ Error while parsing: \(error)")

            return "{ }"
        }
    }
}
