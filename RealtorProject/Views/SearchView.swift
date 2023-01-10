//
//  SearchView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

class SearchView: UIView {
    
    var greetingLabel = UILabel()
    var hungryButton = UIButton()
    var workoutButton = UIButton()
    var boredButton = UIButton()
    var searchBar = UISearchBar()
    var buttonStackView = UIStackView()
    
    func configure(){
        self.backgroundColor = .systemBackground
        self.greetingLabel = configureGreetingLabel()
    }
    
    func configureGreetingLabel() -> UILabel{
        greetingLabel.text = "Hey, World. How are you?"
        
        // Set font wrapping
        greetingLabel.lineBreakMode = .byWordWrapping
        greetingLabel.numberOfLines = 0
        
        // Styling Font
        greetingLabel.textColor = .label
        greetingLabel.textAlignment = .center
        greetingLabel.font = UIFont.systemFont(ofSize: 40)
        greetingLabel.adjustsFontSizeToFitWidth = true

        // Make label corners round corners
        greetingLabel.layer.masksToBounds = true
        greetingLabel.layer.cornerRadius = 25
        
        addSubview(greetingLabel)
        
        // Set constraints
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            greetingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            greetingLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
        return greetingLabel
    }
}
