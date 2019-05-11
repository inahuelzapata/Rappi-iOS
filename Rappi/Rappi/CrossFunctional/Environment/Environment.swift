//
//  Environment.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct Environment {
    fileprivate let infoDict: [String: Any] = {
        var infoDict = [String: Any]()

        if let dict = Bundle.main.infoDictionary {
            infoDict = dict
        }

        return infoDict
    }()

    func configuration(_ key: PlistKey) -> String {
        return getStringValue(by: key)
    }

    private func getStringValue(by key: PlistKey) -> String {
        guard let unwrappredValue = infoDict[key.value] as? String else {
            return String()
        }

        return unwrappredValue
    }
}

enum PlistKey {
    case serverURL
    case accessToken

    var value: String {
        switch self {
        case .accessToken:
            return "AccessToken"
        case .serverURL:
            return "BaseURL"
        }
    }
}
