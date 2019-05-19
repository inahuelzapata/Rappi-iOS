//
//  FeedViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit
import SkeletonView
import UIKit

struct MovieDataStorage: DataStorage {
    let accountID: String
}

class MovieViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    let moviesExposer: MovieExposer =
        MoviesExposer(popularProvider: PopularMovieProvider(requestProvider: current.requestProvider,
                                                            requestBuilder: current.requestBuilder),
                      topRatedProvider: TopRatedMovieProvider(requestProvider: current.requestProvider,
                                                              requestBuilder: current.requestBuilder),
                      upcomingProvider: UpcomingMovieProvider(requestProvider: current.requestProvider,
                                                              requestBuilder: current.requestBuilder))

    var movies: [ShortMovieViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        renderCollectionView()
        retrieveMovies()
    }

    func renderCollectionView() {
        collectionView.registerReusableNibCell(MovieCollectionViewCell.self,
                                               forBundle: Bundle(for: MovieCollectionViewCell.self))

        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 180, height: 180)
        }
    }

    func retrieveMovies() {
        view.showAnimatedGradientSkeleton()

        do {
            try moviesExposer.expose(popularRequest: MovieRequest(page: 1),
                                     topRatedRequest: MovieRequest(page: 1),
                                     upcomingRequest: MovieRequest(page: 1))
                .done { [weak self] movies in
                    self?.movies = movies.compactMap { ShortMovieViewModel(title: $0.movie.title,
                                                                        imagePath: $0.movie.posterPath ?? "",
                                                                        rating: $0.movie.voteAverage,
                                                                        category: $0.category) }

                    self?.view.hideSkeleton()
                    self?.collectionView.reloadData()
                }.cauterize()
        } catch {
            print("❌")
            self.view.hideSkeleton()
        }
    }
}

extension MovieViewController: LargeTitlesNavigation { }

extension MovieViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView,
                                cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MovieCollectionViewCell.reuseIdentifier
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.render(from: movies[indexPath.row])

        return cell
    }

    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 3
    }
}

enum MovieCollectionViewTypes: Int {
    case popular
    case topRated
    case upcoming
}
