//
//  StoryboardIdentable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol StoryboardIdentable {
    var formattedName: String { get }
}

enum FeedStoryboardIdentable {
    case feed
}

extension FeedStoryboardIdentable: StoryboardIdentable {
    var formattedName: String {
        switch self {
        case .feed:
            return "Feed"
        }
    }
}
