//
//  FeedViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

class MovieViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    let accessTokenProvider: AccessTokenProvidable = AccessTokenProvider(requestProvider: currentNetworking.requestProvider,
                                                                         requestBuilder: currentNetworking.requestBuilder)
    let requestTokenProvider: RequestTokenProvidable = RequestTokenProvider(requestProvider: currentNetworking.requestProvider,
                                                                            requestBuilder: currentNetworking.requestBuilder)
    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        view.showAnimatedGradientSkeleton()

        testNetworking()
    }

    func testNetworking() {
        let dto = RequestTokenRequest(redirectTo: "thevegandeveloper.com")

        do {
            try self.requestTokenProvider.execute(request: dto)
                .then { token in
                    return try self.accessTokenProvider.execute(request: AccessTokenRequest(requestToken: token.requestToken.rawValue))
                }.done { accessToken in
                    print("✅ \(accessToken.accountId)")
            }
        } catch {

        }
    }
}

extension MovieViewController: LargeTitlesNavigation { }
