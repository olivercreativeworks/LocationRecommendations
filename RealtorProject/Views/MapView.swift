//
//  MapView.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit
import MapKit
import CoreLocationUI

class MapView: UIView {
    let mapView = MKMapView()
    var currentLocationButton: CLLocationButton? = nil
    
    func configure(searchBarDelegate: UISearchBarDelegate){
        mapView.pin(toSafeAreaOf: self)
        configureCurrentLocationButton()
    }
    
    func configureCurrentLocationButton(){
        currentLocationButton = CLLocationButton(frame: .zero, primaryAction: UIAction (handler: { _ in print("You clicked me!")
        }))
        guard let currentLocationButton = currentLocationButton else { return }
        currentLocationButton.icon = .arrowFilled
        currentLocationButton.label = .shareMyCurrentLocation
        currentLocationButton.cornerRadius = 25.0
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currentLocationButton)
        NSLayoutConstraint.activate([
            currentLocationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentLocationButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension UIView{
    func pin(toSafeAreaOf parentUIView: UIView){
        parentUIView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentUIView.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: parentUIView.safeAreaLayoutGuide.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parentUIView.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentUIView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
