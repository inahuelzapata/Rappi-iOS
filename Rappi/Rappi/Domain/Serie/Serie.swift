//
//  Serie.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Tagged

struct Serie {
    typealias ID = Tagged<Serie, Int>

    let id: ID
    let voteAverage: Double
    let originalName: String
    let adult: Bool
    let popularity: Double
    let posterPath: String
    let name: String
    let overview: String
    let originalLanguage: String
    let voteCount: Int
    let releaseDate: String
    let video: Bool

    let genreIds: [Int]
    let originCountry: [Int]
}

extension Serie: Decodable { }
