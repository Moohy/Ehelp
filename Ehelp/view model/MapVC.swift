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
import UIKit.UIAlertController

class MapVC: UIViewController {
    
    var report: Report!

    let locationManager = CLLocationManager()

    @IBOutlet var mapView: MKMapView!
    
    @IBAction func nextTapped(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsVC
        nextVC.report = report
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func gesRec(_ sender: Any) {
        
        if (sender as AnyObject).state == .began {
            let locationInView = (sender as AnyObject).location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            addAnnotation(location: locationOnMap)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.subtitle = "Current Location"
        mapView.addAnnotation(annotation)
        report.addLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude)
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
//        annotation.title = "Some Title"
//        annotation.subtitle = "Some Subtitle"
        self.mapView.addAnnotation(annotation)
        
        report.addLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude)
    }

}


extension MapVC: CLLocationManagerDelegate,MKMapViewDelegate {

}

