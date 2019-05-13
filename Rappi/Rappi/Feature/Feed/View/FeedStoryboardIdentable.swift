//
//  FeedStoryboardIdentable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/13/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

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

enum FeedControllerIdentable: ViewControllerStoryboardIdentable {
    case tabBar

    var formattedName: String {
        switch self {
        case .tabBar:
            return "FeedTabBarController"
        }
    }
}
