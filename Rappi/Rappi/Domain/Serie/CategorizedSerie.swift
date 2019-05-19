//
//  CategorizedSerie.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

struct CategorizedSerie {
    enum Category {
        case popular
        case topRated
    }

    let serie: Serie
    let category: Category
}
