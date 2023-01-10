//
//  ViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.configure()
        self.view = searchView
        // Do any additional setup after loading the view.
    }


}

