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
    let accessTokenProvider: AccessTokenProvidable = AccessTokenProvider(requestProvider: currentNetworking.requestProvider,
                                                                         requestBuilder: currentNetworking.requestBuilder)
    let requestTokenProvider: RequestTokenProvidable = RequestTokenProvider(requestProvider: currentNetworking.requestProvider,
                                                                            requestBuilder: currentNetworking.requestBuilder)
    private var requestToken: RequestTokenResponse.RequestToken = RequestTokenResponse.RequestToken("")
    let userDefaultsWrapper: UserDefaultable = UserDefaultWrapper()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let sadas = try userDefaultsWrapper.getString(forKey: UserDefaultKey.accountID)

            print(sadas)
        } catch {

        }

        requestTokenAndRedirect { [weak self] in
            self?.presentSafariForGrant(urlString: $0)
        }
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
            }
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
            }
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
