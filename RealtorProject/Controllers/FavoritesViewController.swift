//
//  FavoritesViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    let models = ["Restaurant", "Library", "Park"]

    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: self)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self

        navigationController?.view.backgroundColor = .white
    }

}

extension FavoritesViewController: UISearchBarDelegate, UISearchControllerDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
