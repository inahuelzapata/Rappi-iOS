//
//  CategorizedMovie.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/18/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct CategorizedMovie {
    enum Category {
        case popular
        case topRated
        case upcoming
    }

    let movie: Movie
    let category: Category
}
