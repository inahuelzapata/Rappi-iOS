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

    let id: ID
    let voteAverage: Double
    let originalTitle: String
    let adult: Bool
    let popularity: Double
    let posterPath: String
    let title: String
    let overview: String
    let originalLanguage: String
    let voteCount: Int
    let releaseDate: String
    let video: Bool

    let genreIds: [Int]
}

extension Movie: Decodable { }
