//
//  RecommendationView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import UIKit

class RecommendationView: UIView {
    var addToFavoritesButton = UIButton()
    var infoLabel = UILabel()
    
    // when doing this use the person's curent location - recommendation location to get the delta so both points show up in the map window
    var viewRecommendationOnMapButton = UIButton()
    
    func configure(){
        backgroundColor = .systemBackground
        configureInfoLabel()
        configureAddToFavoritesButton()
        configureViewRecommendationOnMapButton()
    }
    
    func configureInfoLabel(){
        infoLabel.text = "Restaurant Name Here"
        
        // Set font wrapping
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.numberOfLines = 0
        
        // Styling Font
        infoLabel.textColor = .label
//        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.systemFont(ofSize: 40)
        infoLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(infoLabel)
        
        // Set constraints
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
    }
    func configureAddToFavoritesButton(){
        addToFavoritesButton = UIButton(frame:.zero, primaryAction: UIAction(handler: {x in print("Add to favorites")
            guard let btn = x.sender as? UIButton else {return}
            btn.tintColor = .systemRed
        }))
        configureButton(addToFavoritesButton)
        addToFavoritesButton.backgroundColor = .clear
        
        
        addToFavoritesButton.setTitle("Add to Favorites", for: .normal)
        addToFavoritesButton.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        addSubview(addToFavoritesButton)
        NSLayoutConstraint.activate([
            addToFavoritesButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor),
            addToFavoritesButton.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor)
        ])
    }
    func configureViewRecommendationOnMapButton(){
        viewRecommendationOnMapButton = UIButton(frame: .zero, primaryAction: UIAction(handler: { _ in print("Recommendation")}))
        viewRecommendationOnMapButton.setTitle("View On Map", for: .normal)
        configureButton(viewRecommendationOnMapButton)
        addSubview(viewRecommendationOnMapButton)
        NSLayoutConstraint.activate([
            viewRecommendationOnMapButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewRecommendationOnMapButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    private func configureButton(_ button:UIButton){
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10
//        config.baseBackgroundColor = .clear
        button.configuration = config
        
//            $0.backgroundColor = .secondarySystemBackground
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0

        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        
        button.translatesAutoresizingMaskIntoConstraints = false
    }
}
