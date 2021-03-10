//
//  ViewController.swift
//  UberSearchingLocations
//
//  Created by turbo on 10.03.2021.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation


class ViewController: UIViewController, SearchViewControllerDelegat {
    
    
    
    

    var mapView = MKMapView()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        title = "Uber"
        let searchVC = SearchViewController()
        searchVC.delegatee = self
        let panel = FloatingPanelController()
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        
        
    }
    
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        guard let coordinates = coordinates else {
            return
        }
        
        
        
        mapView.removeAnnotations(mapView.annotations)
        
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        
        mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        
    }
    
    
}

