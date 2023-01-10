//
//  MapViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView = MapView()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.configure(searchBarDelegate: self)
//        mapView.searchBarDelegate = self
        self.view = mapView
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self

        navigationController?.view.backgroundColor = .white
    }

}

extension MapViewController: UISearchBarDelegate, UISearchControllerDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
