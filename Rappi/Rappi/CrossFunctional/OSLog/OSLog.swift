//
//  OSLog.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import os

extension OSLog {
    static let networking: OSLog = {
        return OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Networking")
    }()
}
