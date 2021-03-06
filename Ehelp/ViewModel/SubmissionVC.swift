import UIKit
import MapKit
import CoreLocation
import NaturalLanguage
import UIKit.UIAlertController
import CoreData
import Speech


protocol ViewModelDelegate {
    func willLoadData()
    func didLoadData(title: String, message: String, isSuccessful: Bool)
}

class SubmissionVC: UIViewController, ViewModelDelegate {
    
    var reportViewModel = ReportViewModel()
    var apiViewModel = ApiViewModel()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    
    @IBOutlet weak var message: UITextView!
    let locationManager = CLLocationManager()
    
    var emergencyType: String!
    
    var locationLat: Double = 0
    var locationLong: Double = 0
    
    var successfulSubmission: Bool = false
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiViewModel.delegate = self
        
        // add border to the description text view
        self.message.layer.borderColor = UIColor.lightGray.cgColor
        self.message.layer.borderWidth = 1
        self.message.accessibilityIdentifier = "descriptionTV"
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
        
        mapView.mapType = MKMapType.standard
        
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationLat = locValue.latitude
        locationLong = locValue.longitude
        
        currentLocation()
    }
    
    
    /*
     *
     *long press will drop a pin on the pressed location on the map
     *
     */
    @IBAction func gesRec(_ sender: Any) {
        
        if (sender as AnyObject).state == .began {
            let locationInView = (sender as AnyObject).location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            addAnnotation(location: locationOnMap)
        }
    }
    
    /*
    *   Delegate function will start activity indicator
    */
    func willLoadData() {
        activityIndicator?.startAnimating()
    }
    
    /*
     *   Delegate function will stop activity indicator and alert the user of the request result
     */
    func didLoadData(title: String, message: String, isSuccessful: Bool) {
        activityIndicator?.stopAnimating()
        
        //set to true if api request is success
        successfulSubmission = isSuccessful
        
        alert(title: title, message: message)
    }
    
    /*
     *
     * adds annotation to the map
     *
     */
    func addAnnotation(location: CLLocationCoordinate2D, title: String = ""){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.subtitle = title
        self.mapView.addAnnotation(annotation)
        
        locationLat = annotation.coordinate.latitude
        locationLong = annotation.coordinate.longitude
    }
    
    /*
     *
     * displays current location
     *
     */
    func currentLocation() {
        var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D()

        // (latitude, longitude)
        locValue.latitude = locationLat
        locValue.longitude = locationLong
        
        //zoom of the map
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        //passing the coordinates and title of the pin on the map "current location"
        addAnnotation(location: locValue, title: "Current Location")

    }
    
    @IBAction func submitButton(_ sender: Any) {
        // check if description length is less than 10 or greater than 160
        // if so, then alert user to meet the specified length
        if message.text.count < 10 || message.text.count > 160 {
            alert(title: "Error", message: "Make sure you description is more than 10 characters and less than 160 characters")
        } else {
            let reqBody = "\(emergencyType!) - \(message.text!) - Location: \(locationLat), \(locationLong)"
            // api call
            apiViewModel.sendSMS(reqBody: reqBody)
            
            // run this on the main thread after 3 s so it can get the data back from the delegate
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute:{
                if self.successfulSubmission{
                    // add to core data if successful request
                    self.reportViewModel.addReport( emergencyType: self.emergencyType, message: self.message.text!, longitude: self.locationLong, latitude: self.locationLat)
                }
            })
        }
    }
}


extension SubmissionVC: CLLocationManagerDelegate,MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
}
