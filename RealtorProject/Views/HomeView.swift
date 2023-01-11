//
//  SearchView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

protocol HomeViewDelegate{
    func tappedHungryButton()
    func tappedSurpriseMeButton()
}


class HomeView: UIView {
        
    func configure(delegate: HomeViewDelegate?){
        let greetingLabel = configureGreetingLabel(text: "Hey, how are you?")
        let hungryButton = configureButton(title: "I'm hungry", handler:delegate?.tappedHungryButton)
        let surpriseMeButton = configureButton(title: "Surprise Me!", handler: delegate?.tappedSurpriseMeButton)
        let buttonStackView = configureStackView()
        self.backgroundColor = .systemBackground
        
        let buttons: [UIButton] = [hungryButton, surpriseMeButton]
        buttons.forEach{
            buttonStackView.addArrangedSubview($0)
        }
        
        let views = [greetingLabel, buttonStackView]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
      
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            greetingLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20),
            
            buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStackView.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -40)
            ])
    }
    
    private func configureButton(title: String, handler: (() -> Void)?) -> UIButton{
        let button = UIButton(primaryAction: UIAction(title: title, handler:{_ in
            guard let handler = handler else {return}
            handler()
        }))
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10
        config.baseBackgroundColor = .secondarySystemBackground
        button.configuration = config
        
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }
    
    private func configureGreetingLabel(text: String) -> UILabel{
        let greetingLabel = UILabel()
        greetingLabel.text = text
        
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
        
        return greetingLabel
    }
    
    private func configureStackView() -> UIStackView{
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.spacing = 15
        
        return buttonStackView
    }

}
