//
//  FavoritesView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import UIKit

class FavoritesView: UIView {
    
    let table = UITableView()
    
    func configure(tableDelegate: UITableViewDelegate, tableDataSource:UITableViewDataSource){
        table.delegate = tableDelegate
        table.dataSource = tableDataSource
        table.register(FavoritesViewCell.self, forCellReuseIdentifier: FavoritesViewCell.identifier)
        addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.pin(toSafeAreaOf: self)
    }
}


class FavoritesViewCell: UITableViewCell{
    static let identifier = "favoritesCell"
    func configure(text: String){
        var config = self.defaultContentConfiguration()
        config.text = text
        self.contentConfiguration = config
    }
}
