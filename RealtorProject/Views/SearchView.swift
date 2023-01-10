//
//  SearchView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

protocol SearchViewDelegate{
    func tappedHungryButton()
    func tappedWorkoutButton()
    func tappedBoredButton()
    func tappedSearchBarButton()
}


class SearchView: UIView {
    
    var greetingLabel = UILabel()
    var hungryButton: UIButton?
    var workoutButton: UIButton?
    var boredButton: UIButton?
    var searchBar = UISearchBar()
    var buttonStackView = UIStackView()
    
//    var greetingLabel = UILabel()
//    var hungryButton = UIButton(primaryAction: UIAction(title: "I'm Hungry", handler: {_ in
//        self.delegate?.tappedHungryButton()
//    }))
//    var workoutButton = UIButton()
//    var boredButton = UIButton()
//    var searchBar = UISearchBar()
//    var buttonStackView = UIStackView()
    
    var delegate: SearchViewDelegate?
    
    func configure(){
        hungryButton = UIButton(primaryAction: UIAction(title: "I'm Hungry", handler: { [weak self] _ in
            self?.delegate?.tappedHungryButton()
        }))
        workoutButton = UIButton(primaryAction: UIAction(title: "I wanna Workout", handler: { [weak self] _ in
            self?.delegate?.tappedWorkoutButton()
        }))
        boredButton = UIButton(primaryAction: UIAction(title: "I'm Bored", handler: {[weak self] _ in
            self?.delegate?.tappedBoredButton()
        }))
        self.backgroundColor = .systemBackground
        self.greetingLabel = configureGreetingLabel()
        self.buttonStackView = configureButtonStackView()
        self.searchBar = configureSearchBar()
    }
    
    private func configureGreetingLabel() -> UILabel{
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
//            greetingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            greetingLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
        return greetingLabel
    }
    
    private func configureSearchBar() -> UISearchBar{
        searchBar.placeholder = "Where would you like to go?"

        addSubview(searchBar)

        // Set constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 40),
            searchBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchBar.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])

        return searchBar
    }
    
    private func configureButton(_ button:UIButton){
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10
        config.baseBackgroundColor = .secondarySystemBackground
        button.configuration = config
        
//            $0.backgroundColor = .secondarySystemBackground
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0

        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
    }
    
    private func placeButtonInStack(_ button:UIButton, _ buttonStackView: UIStackView){
        buttonStackView.addArrangedSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalTo: buttonStackView.heightAnchor),
            button.widthAnchor.constraint(lessThanOrEqualTo: button.heightAnchor)
        ])
    }
    
    private func configureButtonStackView() -> UIStackView{
        buttonStackView.axis = .horizontal
//        buttonStackView.distribution = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.spacing = 15
        let buttons = [hungryButton, workoutButton, boredButton]
        
//        hungryButton.setTitle("I'm hungry", for: .normal)
        workoutButton?.setTitle("I wanna workout", for: .normal)
        boredButton?.setTitle("I'm bored", for: .normal)
        hungryButton?.titleLabel?.lineBreakStrategy = .standard
        
        buttons.forEach{
            guard let button = $0 else {return}
            configureButton(button)
            placeButtonInStack(button, buttonStackView)
        }
        
        addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            buttonStackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 40),
            buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStackView.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -40)
        ])
        
        return buttonStackView
    }

}
