//
//  MoviesController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit
import SkeletonView
import UIKit

class MoviesController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let moviesExposer: MovieExposer =
        MoviesExposer(popularProvider: PopularMovieProvider(requestProvider: current.requestProvider,
                                                            requestBuilder: current.requestBuilder),
                      topRatedProvider: TopRatedMovieProvider(requestProvider: current.requestProvider,
                                                              requestBuilder: current.requestBuilder),
                      upcomingProvider: UpcomingMovieProvider(requestProvider: current.requestProvider,
                                                              requestBuilder: current.requestBuilder))

    private let sections: [MovieCollectionViewTypes] = [.popular, .topRated, .upcoming]
    private var movies: [ShortMovieViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderTableView()
        retrieveMovies()
    }

    func renderTableView() {
        tableView.registerNib(ScrollableTableViewCell.self, forBundle: Bundle(for: ScrollableTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
                    self?.tableView.reloadData()
                }.cauterize()
        } catch {
            print("❌")
            self.view.hideSkeleton()
        }
    }
}

extension MoviesController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScrollableTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)

        return cell
    }
}

extension MoviesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle(for: TableViewHeader.self).loadView(fromNib: TableViewHeader.reuseIdentifier,
                                                                withType: TableViewHeader.self)
        header.render(title: "Popular 🥇")

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
}

public typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint

public func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>,
                                _ to: KeyPath<UIView, Anchor>,
                                constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: keyPath].constraint(equalTo: parent[keyPath: to], constant: constant)
    }
}

public func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>,
                                constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return equal(keyPath, keyPath, constant: constant)
}

public extension UIView {
    func addSubview(_ child: UIView, constraints: [Constraint]) {
        addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.map { $0(child, self) })
    }
}
extension MoviesController {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}

extension MoviesController: UICollectionViewDataSource {
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

        let movie = movies.filter { $0.category == mapToCategory(int: indexPath.section) }

        cell.render(from: movie[indexPath.row])

        return cell
    }

    func mapToCategory(int: Int) -> CategorizedMovie.Category {
        switch int {
        case 0:
            return .popular

        case 1:
            return .topRated

        case 2:
            return .upcoming

        default:
            return .popular
        }
    }
}

extension MoviesController: UICollectionViewDelegate { }

extension Bundle {
    func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = self.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
