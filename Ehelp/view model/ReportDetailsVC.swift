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

class ReportDetailsVC: UIViewController {
    
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
            let annotation = MKPointAnnotation()
            let locationInView = (sender as AnyObject).location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
        }
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        mapView.removeAnnotation(pin)
//
//        let location = locations.last! as CLLocation
//
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//
//        //set region on the map
//        mapView.setRegion(region, animated: true)
//
//        pin.coordinate = location.coordinate
//        mapView.addAnnotation(pin)
//
//    }
//
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
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let allAnnotations = self.mapView.annotations
        //        annotation2 = loc
        self.mapView.removeAnnotations(allAnnotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Some Title"
        annotation.subtitle = "Some Subtitle"
        self.mapView.addAnnotation(annotation)
        
        report.addLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude)
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
        annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
        report.addLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude)
//        report.addMessage(msg: "Mohammdeeeen")
    }
}
