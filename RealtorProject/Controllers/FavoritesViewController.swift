//
//  FavoritesViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let favoritesView = FavoritesView()
    let models = ["Restaurant", "Library", "Park"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesView.configure(tableDelegate: self, tableDataSource: self)
        self.view = favoritesView
        view.backgroundColor = .systemBackground
        title = "Favorite Places"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesView.table.dequeueReusableCell(withIdentifier: FavoritesViewCell.identifier, for: indexPath) as? FavoritesViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.configure(text:model)
        return cell
    }
    
}
