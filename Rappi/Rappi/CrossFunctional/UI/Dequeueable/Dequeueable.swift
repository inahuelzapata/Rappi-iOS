//
//  Dequeueable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol Dequeueable {
    static var reuseIdentifier: String { get }
}

extension Dequeueable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
