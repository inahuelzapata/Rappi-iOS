//
//  Movie.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct Movie { }

extension Movie {
    static let endgame: Movie = { return Movie() }()
    static let infinityWar: Movie = { return Movie() }()
    static let captainAmerica: Movie = { return Movie() }()
}

extension Movie: Decodable { }
