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

    var sections: [MovieCollectionViewTypes] = [.popular, .topRated, .upcoming]

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        renderCollectionView()
        retrieveMovies()
    }

    func renderCollectionView() {
        collectionView.registerReusableNibCell(MovieCollectionViewCell.self,
                                               forBundle: Bundle(for: MovieCollectionViewCell.self))
        collectionView.registerReusableNibView(HeaderCollectionReusableView.self,
                                               kind: UICollectionView.elementKindSectionHeader,
                                               forBundle: Bundle(for: HeaderCollectionReusableView.self))

        collectionView.dataSource = self
        collectionView.delegate = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 180, height: 180)
            layout.sectionHeadersPinToVisibleBounds = true
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
        switch section {
        case 0:
            return movies.filter { $0.category == .popular }.count

        case 1:
            return movies.filter { $0.category == .topRated }.count

        case 2:
            return movies.filter { $0.category == .upcoming }.count

        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.render(from: movies[indexPath.row])

        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 64)
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header: HeaderCollectionReusableView = collectionView.dequeueReusableView(for: indexPath, ofKind: kind)

        switch indexPath.section {
        case 0:
            header.renderTitle("Popular 🥇")

        case 1:
            header.renderTitle("Top Rated 🔝")

        case 2:
            header.renderTitle("Upcoming Movies 📆")

        default:
            return UICollectionReusableView()
        }

        return header
    }
}

enum MovieCollectionViewTypes: Int {
    case popular
    case topRated
    case upcoming
}
