//
//  AuthorizationRouter.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol AuthorizationRoutingLogic {
    init(controller: AuthorizationViewController?)

    func routeToFeed()
}

class AuthorizationRouter: AuthorizationRoutingLogic {
    weak var controller: AuthorizationViewController?

    required init(controller: AuthorizationViewController?) {
        self.controller = controller
    }

    func routeToFeed() {

    }
}
