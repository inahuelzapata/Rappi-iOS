//
//  DataStorage.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol DataStorage { }

struct EmptyStore: DataStorage { }

struct RequiredStorage<Store: DataStorage> {
    let store: Store
    let storyboardName: StoryboardIdentable
    let controllerIdentifier: ViewControllerStoryboardIdentable
}
