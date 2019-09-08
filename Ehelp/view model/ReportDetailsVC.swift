//
//  ReportDetailsVCViewController.swift
//  Ehelp
//
//  Created by Mohammed on 6/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ReportDetailsVC: UIViewController {
    var report: Report!
    let locationManager = CLLocationManager()

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    
    

}


extension ReportDetailsVC: CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
//        annotation.title = "Javed Multani"
        annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
        
//        centerMap(locValue)
    }
}
