import UIKit
import MapKit
import CoreLocation
import NaturalLanguage
import UIKit.UIAlertController

class SubmissionVC: UIViewController {
    
    var reportViewModel = ReportViewModel()
    
    @IBOutlet weak var message: UITextView!
    let locationManager = CLLocationManager()
    
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
        
        // add border to the description text view
        self.message.layer.borderColor = UIColor.lightGray.cgColor
        self.message.layer.borderWidth = 1
        self.message.accessibilityIdentifier = "descriptionTV"

        // keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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

        currentLocation()
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
        
        // set the location on the model to the new location
        reportViewModel.addLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude)
    }
    
    /*
     *
     * displays current location
     *
     */
    func currentLocation() {
        //current coordinates grapped from location manager on the device
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
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
        reportViewModel.addDate()
        
        // check if description length is less than 10 or greater than 160
        // if so, then alert user to meet the specified length
        if message.text.count < 10 || message.text.count > 160 {
            
            let alertController:UIAlertController = UIAlertController(title: "Error", message: "Make sure you description is more than 10 characters and less than 160 characters", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction:UIAlertAction = UIAlertAction(title: "Message", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            // Add message after validation
            reportViewModel.addMessage(msg: message.text)

            // append the reportViewModel to the singlton reports array of reportViewModel objects
            // to be retrieved globally on the app when ever intialized
            Global.shared.reports.append(reportViewModel)
        }
        
        
        // show message if criteria are met
        let alertController:UIAlertController = UIAlertController(title: "Message", message: "Report has been filed successfully", preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "Back", style: .cancel, handler:
        { action in
            // pop this view controller and go back to root view controller
            self.navigationController?.popToRootViewController(animated: true)
        } )
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension SubmissionVC: CLLocationManagerDelegate,MKMapViewDelegate {
    
}

