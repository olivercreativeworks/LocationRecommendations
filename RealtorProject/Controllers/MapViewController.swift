//
//  MapViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit
import CoreLocation
import CoreLocationUI
import MapKit

class CustomAnnotation: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

class MapViewController: UIViewController {
    let mapView = MKMapView()
    var currentLocationButton: CLLocationButton!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        mapView.delegate = self
        
        mapView.register(CustomAnnotation.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self))
        addMapToView()
        configureCurrentLocationButton()
        addPinToMapView()
    }
    
    func configureCurrentLocationButton(){
        currentLocationButton = CLLocationButton(frame: .zero, primaryAction: UIAction(handler: {[weak self] _ in
            guard let gSelf = self else { return }
            print("Authorization already granted")
            gSelf.getLocationFn(from: gSelf.manager)
        }))
        currentLocationButton.icon = .arrowFilled
        currentLocationButton.label = .sendCurrentLocation
        currentLocationButton.cornerRadius = 25.0

        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationButton)
        NSLayoutConstraint.activate([
            currentLocationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currentLocationButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    
    func addPinToMapView(){
//        let pin = CustomAnnotation(title: "Me", coordinate: CLLocationCoordinate2D(latitude: 47, longitude: -122), info: "Nice place")
        let pin2 = MKPointAnnotation()
        pin2.coordinate = CLLocationCoordinate2D(latitude: 47, longitude: -122)
        pin2.title = "Happy B-day"
        pin2.subtitle = "Hello"
        mapView.addAnnotation(pin2)
    }
    
    func addMapToView(){
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let id = NSStringFromClass(CustomAnnotation.self)
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(systemName: "figure.wave.circle")
            annotationView?.leftCalloutAccessoryView = UIImageView(image: UIImage(systemName: "star"))
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("I was tapped")
    }
}

extension MapViewController:CLLocationManagerDelegate{
    func getLocationFn(from manager: CLLocationManager){
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        print("Got a location")
        manager.stopUpdatingLocation()
        render(location, mapView: self.mapView)
    }
    
    func render(_ location:CLLocation, mapView: MKMapView){
        print("Our current location is: lat: \(location.coordinate.latitude), lon: \(location.coordinate.longitude)")
        
        let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.01),
                                    longitudeDelta: CLLocationDegrees(0.01))
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
//        let pin = CustomAnnotation(title: "Hello World", coordinate: location.coordinate, info: "It is a good place")
        let pin = MKPointAnnotation()
        pin.title = "Hello"
        pin.subtitle = "World"
        pin.coordinate = location.coordinate
        
        mapView.addAnnotation(pin)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
           case .authorizedWhenInUse:  // Location services are available.
                print("Authorized")
                getLocationFn(from: manager)
               break

           case .restricted, .denied:  // Location services currently unavailable.
               print("Not authorized")
               break

           default:
               break
           }
    }
}
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is CustomAnnotation else { return nil }
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotation.id)
//        if annotationView == nil {
//            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotation.id)
//            annotationView?.canShowCallout = true
//
//            let button = UIButton(type: .detailDisclosure)
//            annotationView?.rightCalloutAccessoryView = button
//        }
//        annotationView?.annotation = annotation
//        return annotationView
//    }
//}

//class MapViewController: UIViewController, LocationButtonDelegate, CLLocationManagerDelegate {
//    func getCurrentLocation() {
////        switch locationManager.authorizationStatus{
//////        case .notDetermined:
////////            locationManager.requestWhenInUseAuthorization()
//////            break
////        case .authorizedWhenInUse, .authorizedAlways:
////            getLocationFn(from: locationManager)
////            break
////        default:
////            print("We do not have the right permission")
////            break
////        }
////        print("I will get the current location")
//    }
//
//    func getLocationFn(from manager: CLLocationManager){
//        manager.startUpdatingLocation()
//        let userLocationButton = configureUserLocationButton(mapView: mapView.mapView, view: self.view)
//        print("We made it now")
//    }
//
//    func render(_ location:CLLocation, mapView: MKMapView){
//        print("Our current location is: lat: \(location.coordinate.latitude), lon: \(location.coordinate.longitude)")
//
//        let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.01),
//                                            longitudeDelta: CLLocationDegrees(0.01))
//        let region = MKCoordinateRegion(center: location.coordinate, span: span)
//
//        mapView.setRegion(region, animated: true)
//        let pin = CustomAnnotation(title: "Hello World", coordinate: location.coordinate, info: "It is a good place")
////        let pinw = MKPointAnnotation()
////        pin.title = "Hello World"
////        pin.subtitle = "It is a good place"
////        pin.coordinate = location.coordinate
//        mapView.addAnnotation(pin)
//    }
//
//    func configureUserLocationButton(mapView: MKMapView, view:UIView) -> MKUserTrackingButton{
//        let button = MKUserTrackingButton(mapView: mapView)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        return button
//    }
//
//    let mapView = MapView()
////    let searchController = UISearchController(searchResultsController: nil)
//    let locationManager = CLLocationManager()
//
//    func setupCustomAnnotationView(for annotation: MKAnnotation, on mapView: MKMapView ) -> MKAnnotationView{
//        print("You are in the destination annotation view fn")
//        let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotation.id, for: annotation)
//
//        customAnnotationView.canShowCallout = true
//
//        // show a star if favorited
//        customAnnotationView.leftCalloutAccessoryView = UIImageView(image: UIImage( systemName: "star"))
//        customAnnotationView.detailCalloutAccessoryView = UIImageView(image: UIImage( systemName: "star"))
//
//        return customAnnotationView
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        print("I was tapped")
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print("In view for")
//        guard !annotation.isKind(of: MKUserLocation.self) else {
//             return nil
//        }
//        var annotationView: MKAnnotationView?
//
//        let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotation.id, for: annotation)
//
//        customAnnotationView.canShowCallout = true
//        // show a star if favorited
//        customAnnotationView.leftCalloutAccessoryView = UIImageView(image: UIImage( systemName: "star"))
//        customAnnotationView.detailCalloutAccessoryView = UIImageView(image: UIImage( systemName: "star"))
//        return annotationView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//
//        mapView.locationButtonDelegate = self
//        mapView.configure(searchBarDelegate: self)
//        //        mapView.searchBarDelegate = self
//        self.view = mapView
//        title = "Map View"
//        navigationController?.navigationBar.prefersLargeTitles = true
////        navigationItem.searchController = searchController
////        searchController.searchBar.delegate = self
//
//        navigationController?.view.backgroundColor = .white
//        mapView.mapView.register(CustomAnnotation.self, forAnnotationViewWithReuseIdentifier: CustomAnnotation.id)
//
//
////        let request = MKDirections.Request()
////        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059), addressDictionary: nil))
////        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -75.0059), addressDictionary: nil))
//////        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667), addressDictionary: nil))
////        request.requestsAlternateRoutes = true
////        request.transportType = .automobile
//
//        let pin1 = MKPointAnnotation()
//        pin1.coordinate = CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059)
//        mapView.mapView.addAnnotation(pin1)
//
////        let directions = MKDirections(request: request)
////
////        directions.calculate { [unowned self] response, error in
////            guard let unwrappedResponse = response else { return }
////            if let route = unwrappedResponse.routes.first{
////                print(route.distance)
////
////                self.mapView.mapView.addOverlay(route.polyline, level:.aboveRoads)
////                let customEdgePadding = UIEdgeInsets(
////                    top: 50,
////                    left: 50,
////                    bottom: 50,
////                    right: 50
////                )
////
////                self.mapView.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: customEdgePadding, animated: true)
////            }
////        }
////            for route in unwrappedResponse.routes {
////
////                print(route.distance)
////
////                self.mapView.mapView.addOverlay(route.polyline, level:.aboveRoads)
////                let customEdgePadding = UIEdgeInsets(
////                    top: 50,
////                    left: 50,
////                    bottom: 50,
////                    right: 50
////                )
////
////                self.mapView.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: customEdgePadding, animated: true)
////            }
//        }
//    }
//
//extension MapViewController: UISearchBarDelegate, UISearchControllerDelegate, MKMapViewDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//    }
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        guard let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline) as? MKGradientPolylineRenderer else {return MKPolylineRenderer()}
//        renderer.setColors([
//            .red, .orange, .brown
//        ], locations: [])
//        renderer.lineCap = .round
//        renderer.lineWidth = 3
//
//        return renderer
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//           case .authorizedWhenInUse:  // Location services are available.
//                print("Authorized")
//                getLocationFn(from: locationManager)
//               break
//
//           case .restricted, .denied:  // Location services currently unavailable.
//               print("Not authorized")
//               break
//
//           default:
//               break
//           }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        render(location, mapView: self.mapView.mapView)
//        manager.stopUpdatingLocation()
//    }
//}
