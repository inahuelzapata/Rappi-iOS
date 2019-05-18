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

struct MovieDataStorage: DataStorage {
    let accountID: String
}

class MovieViewController: StorableBaseController {
    var store: DataStorage!

    @IBOutlet private weak var collectionView: UICollectionView!

    let moviesExposer: MovieExposer = MoviesExposer(popularProvider: PopularMovieProvider(requestProvider: current.requestProvider,
                                                                                          requestBuilder: current.requestBuilder),
                                                    topRatedProvider: TopRatedMovieProvider(requestProvider: current.requestProvider,
                                                                                            requestBuilder: current.requestBuilder),
                                                    upcomingProvider: UpcomingMovieProvider(requestProvider: current.requestProvider,
                                                                                            requestBuilder: current.requestBuilder))

    var movies: [ShortMovieViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()

        retrieveMovies()
    }

    func retrieveMovies() {
        view.showAnimatedGradientSkeleton()

        do {
            try moviesExposer.expose(popularRequest: MovieRequest(page: 1),
                                     topRatedRequest: MovieRequest(page: 1),
                                     upcomingRequest: MovieRequest(page: 1))
                .done { [weak self] rumine in
                    print("Josha 💎: \(rumine.count)")
                    let topRated = rumine.filter { $0.category == .topRated }.count
                    let popular = rumine.filter { $0.category == .popular }.count
                    let upcoming = rumine.filter { $0.category == .upcoming }.count
                    print("NO BARATS 💎 TOP 🔝: \(topRated)")
                    print("Josha 💎 POPULAR 💵 : \(popular)")
                    print("UPCOMING 📩 : \(upcoming)")

                    self?.view.hideSkeleton()
            }
        } catch {
            print("❌")
            self.view.hideSkeleton()
        }
    }
}

extension MovieViewController: LargeTitlesNavigation { }

struct ShortMovieViewModel {
    let title: String
    let imagePath: String
    let rating: Double
}
