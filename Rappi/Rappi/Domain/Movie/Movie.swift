//
//  Movie.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/11/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Tagged

struct Movie {
    typealias ID = Tagged<Movie, Int>

    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]

    let id: ID
    let originalTitle: String
    let originalLanguage: String
    let title: String

    let popularity: Double

    let voteCount: Int
    let video: Bool
    let voteAverage: Double
}

extension Movie: Decodable { }
