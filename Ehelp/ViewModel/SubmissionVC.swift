import UIKit
import MapKit
import CoreLocation
import NaturalLanguage
import UIKit.UIAlertController
import CoreData
import Speech


protocol ViewModelDelegate {
    func willLoadData()
    func didLoadData(title: String, message: String)
}

protocol ViewModelType {
    func pass(reqBody: String)
//    var delegate: ViewModelDelegate? { get set }
}

class SubmissionVC: UIViewController, ViewModelDelegate {
    
    var reportViewModel = ReportViewModel()
    var apiViewModel = ApiViewModel()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var emergencyType: String!
    
    @IBOutlet weak var message: UITextView!
    let locationManager = CLLocationManager()
    
    var locationLat: Double = 0
    var locationLong: Double = 0
    
    @IBOutlet var mapView: MKMapView!
    
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiViewModel.delegate = self
        
        // add border to the description text view
        self.message.layer.borderColor = UIColor.lightGray.cgColor
        self.message.layer.borderWidth = 1
        self.message.accessibilityIdentifier = "descriptionTV"

        // keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        
//        activityIndicator.hidesWhenStopped = true
    }
    
    func willLoadData() {
        activityIndicator?.startAnimating()
    }
    
    func didLoadData(title: String, message: String) {
        sleep(3)
        activityIndicator?.stopAnimating()
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
        
        // set the location on the model to the new location
//        reportViewModel.addLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude)
    }
    
    /*
     *
     * displays current location
     *
     */
    func currentLocation() {
        var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D()

        locValue.latitude = locationLat
        locValue.longitude = locationLong
        
        print(locationLat, ", ", locationLong)
        //zoom of the map
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        //passing the coordinates and title of the pin on the map "current location"
        addAnnotation(location: locValue, title: "Current Location")

    }
    

    /*
     *
     * show keyboard and move view up
     *
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    /*
     *
     * hide keyboard move view down
     *
     */
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        // add current date to view model
//        reportViewModel.addDate()
        
        // check if description length is less than 10 or greater than 160
        // if so, then alert user to meet the specified length
        if message.text.count < 10 || message.text.count > 160 {
            
            let alertController:UIAlertController = UIAlertController(title: "Error", message: "Make sure you description is more than 10 characters and less than 160 characters", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction:UIAlertAction = UIAlertAction(title: "Message", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            reportViewModel.addReport( emergencyType: emergencyType, message: message.text!, longitude: locationLong, latitude: locationLat)
            
            let reqBody = "\(emergencyType!) - \(message.text!) - Location: \(locationLat), \(locationLong)"
            
            // api call
            apiViewModel.sendSMS(reqBody: reqBody)
        }
    }
}


extension SubmissionVC: CLLocationManagerDelegate,MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
}
