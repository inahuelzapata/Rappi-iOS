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

        var title: String {
            switch self {
            case .popular:
                return "💎 Popular 💎"
            case .topRated:
                return "🔝 Top Rated 🔝"
            case .upcoming:
                return "📆 Upcoming 📆"
            }
        }
    }

    let movie: Movie
    let category: Category
}
