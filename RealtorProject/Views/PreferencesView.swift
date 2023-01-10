//
//  PreferencesView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

class PreferencesView: UIView {
    var greetingLabel = UILabel()
    var ratingButton: UIButton?
    var distanceButton: UIButton?
    
    var buttonStackView = UIStackView()
    
    var delegate: SearchViewDelegate?
    
    func configure(){
        ratingButton = UIButton(primaryAction: UIAction(title: "Rating", handler: { [weak self] _ in
            self?.delegate?.tappedHungryButton()
        }))
        distanceButton = UIButton(primaryAction: UIAction(title: "Distance", handler: { [weak self] _ in
            self?.delegate?.tappedWorkoutButton()
        }))
        
        self.backgroundColor = .systemBackground
        self.greetingLabel = configureGreetingLabel()
        self.buttonStackView = configureButtonStackView()
        
    }
    
    private func configureGreetingLabel() -> UILabel{
        greetingLabel.text = "Which do you prefer?"
        
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
            greetingLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
        return greetingLabel
    }
    
    private func configureButton(_ button:UIButton){
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10
        config.baseBackgroundColor = .secondarySystemBackground
        button.configuration = config
        
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
            button.heightAnchor.constraint(equalToConstant: 160),
            button.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func configureButtonStackView() -> UIStackView{
        buttonStackView.axis = .horizontal
        
        buttonStackView.alignment = .center
        buttonStackView.spacing = 30
        let buttons = [ratingButton, distanceButton]
        
        ratingButton?.titleLabel?.lineBreakStrategy = .standard
        
        buttons.forEach{
            guard let button = $0 else {return}
            configureButton(button)
            placeButtonInStack(button, buttonStackView)
        }
        
        addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStackView.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -40)
        ])
        
        return buttonStackView
    }
}
