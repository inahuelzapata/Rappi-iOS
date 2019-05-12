//
//  Account.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Tagged

struct Account {
    typealias AccountID = Tagged<Account, String>

    let accountID: AccountID
}

extension Account: Decodable { }
