//
//  StoryboardInitiable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInitiable {
    func initStoryboardInitialViewController<T: UIViewController>(with storyboardID: StoryboardIdentable,
                                                                  on bundle: Bundle) throws -> T

    func initStoryboardViewController<T: UIViewController>(with storyboardID: StoryboardIdentable,
                                                           controllerID: ViewControllerStoryboardIdentable,
                                                           on bundle: Bundle) throws -> T
}

extension StoryboardInitiable {
    func initStoryboardInitialViewController<T: UIViewController>(with storyboardID: StoryboardIdentable,
                                                                  on bundle: Bundle = Bundle.main) throws -> T {
        let initialController = UIStoryboard(name: storyboardID.formattedName,
                                             bundle: bundle).instantiateInitialViewController()

        guard let expectedController = initialController as? T else {
            throw CommonError.casting
        }

        return expectedController
    }

    func initStoryboardViewController<T: UIViewController>(with storyboardID: StoryboardIdentable,
                                                           controllerID: ViewControllerStoryboardIdentable,
                                                           on bundle: Bundle = Bundle.main) throws -> T {
        let storyboard = UIStoryboard(name: storyboardID.formattedName,
                                      bundle: bundle)

        let controller = storyboard.instantiateViewController(withIdentifier: controllerID.formattedName)

        guard let expectedController = controller as? T else {
            throw CommonError.casting
        }

        return expectedController
    }
}
