//
//  AuthorizationViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import SafariServices
import UIKit

class AuthorizationViewController: UIViewController {
    let accessTokenProvider: AccessTokenProvidable = AccessTokenProvider(requestProvider: current.requestProvider,
                                                                         requestBuilder: current.requestBuilder)
    let requestTokenProvider: RequestTokenProvidable = RequestTokenProvider(requestProvider: current.requestProvider,
                                                                            requestBuilder: current.requestBuilder)
    private var requestToken: RequestTokenResponse.RequestToken = RequestTokenResponse.RequestToken("")
    let userDefaultsWrapper: UserDefaultable = UserDefaultWrapper()
    var router: AuthorizationRoutingLogic?

    override func viewDidLoad() {
        super.viewDidLoad()

        injectDependencies()

        do {
            let accountID = try userDefaultsWrapper.getString(forKey: UserDefaultKey.accountID)

            router?.routeToFeed()
        } catch {
            requestTokenAndRedirect { [weak self] in
                self?.presentSafariForGrant(urlString: $0)
            }
        }
    }

    func injectDependencies() {
        weak var controller = self

        router = AuthorizationRouter(controller: controller)
    }

    func presentSafariForGrant(urlString: String) {
        let safariController = SFSafariViewController(url: URL(string: urlString)!)

        self.present(safariController, animated: true, completion: nil)

        safariController.delegate = self
    }

    func requestTokenAndRedirect(redirect: @escaping (String) -> Void) {
        do {
            try requestTokenProvider.execute(request: RequestTokenRequest(redirectTo: "http://www.themoviedb.org/"))
                .done {
                    self.requestToken = $0.requestToken
                    redirect("https://www.themoviedb.org/auth/access?request_token=\($0.requestToken.rawValue)")
                }.cauterize()
        } catch {
            // Show Error popUp
        }
    }

    func requestAccessToken() {
        do {
            try accessTokenProvider.execute(request: AccessTokenRequest(requestToken: requestToken))
                .done {
                    self.userDefaultsWrapper.saveString(value: $0.accountId.rawValue,
                                                        forKey: UserDefaultKey.accountID)
                }.cauterize()
        } catch {
            // Show Error popUp
        }
    }
}

extension AuthorizationViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
        requestAccessToken()
    }
}
