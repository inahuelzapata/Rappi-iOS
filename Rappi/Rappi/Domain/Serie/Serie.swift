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
    let originalName: String
    let genreIds: [Int]
    let name: String
    let popularity: Double
    let originCountry: [String]

    let firstAirDate: String
    let originalLanguage: String
    let voteCount: Int
    let voteAverage: Double

    let overview: String
    let posterPath: String
}

extension Serie: Decodable { }

struct CategorizedSerie {
    enum SerieCategory {
        case popular
        case topRated
    }

    let serie: Serie
    let category: SerieCategory
}
