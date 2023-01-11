//
//  ViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit
import CoreLocation

protocol HomeViewControllerDelegate{
    func getRecommendations(profile:FourSquareAPIUrlOptions)
    func queryFourSquareAPI(profile:FourSquareAPIUrlOptions)
}

class HomeViewController: UIViewController {
    let homeView = HomeView()
    var categoryCode: FourSquarePlaceCategoryTaxonomyCode? = nil
    var delegate: HomeViewControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.configure(delegate: self)
        self.view = homeView
    }
}

struct HomeViewViewModel{
    var category: Int?
}

extension HomeViewController: HomeViewDelegate, MapViewControllerDelegate{
    func buttonTapped(categoryCode: FourSquarePlaceCategoryTaxonomyCode){
        print(categoryCode.rawValue)
        self.categoryCode = categoryCode
        let mapViewController = MapViewController()
        mapViewController.delegate = self
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func tappedHungryButton() {
        let categoryCode = FourSquarePlaceCategoryTaxonomyCode.diningAndDrinking
        buttonTapped(categoryCode: categoryCode)
    }

    func tappedSurpriseMeButton() {
        guard let categoryCode = [FourSquarePlaceCategoryTaxonomyCode.diningAndDrinking, FourSquarePlaceCategoryTaxonomyCode.artsAndentertainment, FourSquarePlaceCategoryTaxonomyCode.landmarks, FourSquarePlaceCategoryTaxonomyCode.sportsAndRecreation].randomElement() else {
            return
        }
        buttonTapped(categoryCode: categoryCode)
    }
    
    func findPlaces(near location: CLLocationCoordinate2D){
        guard let categoryCode = self.categoryCode else {return}
        let startLocation = StartLocation(coordinates: Coordinates(latitude: location.latitude, longitude: location.longitude))
        self.delegate?.getRecommendations(profile: FourSquareAPIUrlOptions(
            startLocation: startLocation,
            category: FourSquareCategoriesOption(
                categories:categoryCode)))
    }
    
}
