//
//  AuthorizationRouter.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol AuthorizationRoutingLogic: Navigator {
    init(controller: AuthorizationViewController?)

    func routeToFeed()
}

class AuthorizationRouter: AuthorizationRoutingLogic {
    weak var controller: AuthorizationViewController?

    required init(controller: AuthorizationViewController?) {
        self.controller = controller
    }

    func routeToFeed() {
        do {
            let destinationController = try initStoryboardInitialViewController(with: FeedStoryboardIdentable.feed)

            navigate(from: controller, to: destinationController, with: .present)
        } catch {
            // Error Handling
        }
    }
}
