//
//  ViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

class SearchViewController: UIViewController, SearchViewDelegate {
    func tappedHungryButton() {
        let vc = PreferencesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print("I'm Hungry")
    }
    
    func tappedWorkoutButton() {
        let mapVc = MapViewController()
        self.navigationController?.pushViewController(mapVc, animated: true)
        print("I wanna workout")
    }
    
    func tappedBoredButton() {
        print("I'm bored")
    }
    
    func tappedSearchBarButton() {
        print("Search Button Tapped")
    }
    

    let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.configure()
        searchView.delegate = self
        self.view = searchView
        // Do any additional setup after loading the view.
    }
    

}

