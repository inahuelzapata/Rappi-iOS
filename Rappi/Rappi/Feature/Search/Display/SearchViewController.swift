//
//  SearchViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    @IBOutlet private weak var searchTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var movies: [CategorizedMovie] = []

    var moviesFiltered: [CategorizedMovie] = []

    var isFiltering: Bool {
        return searchController.isActive && !emptySearchBar
    }

    var emptySearchBar: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        renderSearchBar()
    }

    func renderSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.scopeButtonTitles = ["Movies", "Series"]
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        moviesFiltered = movies.filter {
            $0.movie.title.lowercased().contains(searchText.lowercased())
        }

        searchTableView.reloadData()
    }
}

extension SearchViewController: LargeTitlesNavigation { }

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return moviesFiltered.count
        }

        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SearchViewController: UISearchBarDelegate {

}
