//
//  FeedViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

class MovieViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    let movieProvider: MovieProvidable = MovieProvider(requestProvider: current.requestProvider,
                                                            requestBuilder: current.requestBuilder)

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        view.showAnimatedGradientSkeleton()
    }

    func retrieveMovies() {
        do {
            try movieProvider.execute(request: MovieRequest(page: 1)).done {
                print(($0.results.count))
            }
        } catch {

        }
    }
}

extension MovieViewController: LargeTitlesNavigation { }
