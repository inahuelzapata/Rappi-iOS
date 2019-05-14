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

    let movieProvider: MovieProvidable = MovieProvider(requestProvider: current.requestProvider,
                                                       requestBuilder: current.requestBuilder)

    var movies: [ShortMovieViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        view.showAnimatedGradientSkeleton()

        retrieveMovies()
    }

    func retrieveMovies() {
        do {
            try movieProvider.execute(request: MovieRequest(page: 1))
                .done {
                    print(($0.results.count))

                    self.movies = $0.results.map { ShortMovieViewModel(title: $0.title,
                                                                       imagePath: $0.posterPath ?? String(), // FIXME
                                                                       rating: $0.popularity) }
            }
        } catch { }
    }
}

extension MovieViewController: LargeTitlesNavigation { }

struct ShortMovieViewModel {
    let title: String
    let imagePath: String
    let rating: Double
}
