//
//  Serie.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct Serie { }

extension Serie {
    static let dexter: Serie = { return Serie() }()
    static let gameOfThrones: Serie = { return Serie() }()
    static let narcos: Serie = { return Serie() }()
}

extension Serie: Decodable { }
