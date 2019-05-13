//
//  Navigator.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

typealias StorableBaseController = UIViewController & ViewControllerStorable

protocol Navigator: StoryboardInitiable {
    func navigate<T: UIViewController>(from source: T?, to destination: T,
                                       with navigationStrategy: NavigationStrategy)

    func navigate<T: UIViewController>(from source: T?, to destination: T,
                                       with navigationStrategy: NavigationStrategy,
                                       completion: @escaping () -> Void)

    func createViewController<T: DataStorage>(with requiredStore: RequiredStorage<T>) throws -> UIViewController

    func navigateToViewController<T: UIViewController, U: DataStorage>(from source: T?,
                                                                       initStore: RequiredStorage<U>,
                                                                       with navigationStrategy: NavigationStrategy)
}

extension Navigator {
    func navigate<T: UIViewController>(from source: T?, to destination: T,
                                       with navigationStrategy: NavigationStrategy) {
        navigate(from: source, to: destination, with: navigationStrategy, completion: { })
    }

    func navigate<T: UIViewController>(from source: T?, to destination: T,
                                       with navigationStrategy: NavigationStrategy,
                                       completion: @escaping () -> Void) {
        switch navigationStrategy {
        case .present:
            source?.present(destination, animated: true, completion: completion)

        case .push:
            source?.navigationController?.pushViewController(destination, animated: true)

        case .replaceInWindow:
            if let keyWindow = UIApplication.shared.keyWindow {
                UIView.transition(with: keyWindow,
                                  duration: 0.3,
                                  options: .transitionFlipFromLeft,
                                  animations: {
                                      keyWindow.rootViewController = destination
                                  }, completion: { _ in
                                      if let controller = source?.navigationController {
                                          controller.dismiss(animated: false, completion: completion)
                                      } else {
                                          completion()
                                      }
                                  })
            }
        }
    }

    func navigateToViewController<T, U>(from source: T?,
                                        initStore: RequiredStorage<U>,
                                        with navigationStrategy: NavigationStrategy)
    where T: UIViewController, U: DataStorage {
        do {
            let destinationController = try createViewController(with: initStore)
            navigate(from: source, to: destinationController, with: navigationStrategy)
        } catch {
            assertionFailure("Controller with identifier \(initStore.controllerIdentifier) can't be created")
        }
    }

    func createViewController<U: UIViewController, T: DataStorage>(_ initStore: RequiredStorage<T>)
    throws -> U {
        return try initStoryboardViewController(with: initStore.storyboardName,
                                                controllerID: initStore.controllerIdentifier,
                                                on: Bundle.main)
    }

    func createStorableViewController<T: DataStorage>(_ initStore: RequiredStorage<T>)
    throws -> UIViewController {
        guard var controller = try createViewController(initStore) as? StorableBaseController else {
            throw CommonError.casting
        }
        controller.store = initStore.store
        return controller
    }
}
