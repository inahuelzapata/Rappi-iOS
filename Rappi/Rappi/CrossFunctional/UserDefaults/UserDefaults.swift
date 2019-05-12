//
//  UserDefaults.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol UserDefaultKeyable {
    var value: String { get }
}

enum UserDefaultKey: UserDefaultKeyable {
    case accountID

    var value: String {
        switch self {
        case .accountID:
            return "accountID"
        }
    }
}

protocol UserDefaultable {
    init(userDefaults: UserDefaults)

    func saveString(value: String, forKey key: UserDefaultKeyable)

    func getString(forKey key: UserDefaultKeyable) throws -> String
}

struct UserDefaultWrapper: UserDefaultable {
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveString(value: String, forKey key: UserDefaultKeyable) {
        userDefaults.set(value, forKey: key.value)
    }

    func getString(forKey key: UserDefaultKeyable) throws -> String {
        if let value = userDefaults.value(forKey: key.value) as? String {
            return value
        }

        throw CommonError.casting
    }
}
