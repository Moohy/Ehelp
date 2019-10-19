import UIKit
import MapKit
class TableCellReportDetailsVC: UIViewController {
    

    // initalize buttons and other variables
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var textView: UITextView!
    var message: String!
    var latitude: Double!
    var longitude: Double!
    
     // load view model function, triggers when scene is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // call set up text view function
        setupTextView()
        // call present location function
        presentLocation()

    }
    

    // text view object customization and configration

    func setupTextView() {
    // add border to the description text view
    self.textView.layer.borderColor = UIColor.lightGray.cgColor
    self.textView.layer.borderWidth = 1
    // assign message to the text view
    textView.text = message
    // disable the text view of being editable
    textView.isEditable = false
    }
    
    // setup the map to the given coordinate for the report
    func presentLocation(){
        
        self.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        // assign coordinates to coor variable
        let coor = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        // assign coordinate and zoom
        let region = MKCoordinateRegion(center: coor, span: span)
        // make changes of the assigned region on the map
        self.mapView.setRegion(region, animated: true)
        // add annotation to the map
        let annotation = MKPointAnnotation()
        // set the annotation to the coordinate
        annotation.coordinate = coor
        self.mapView.addAnnotation(annotation)

    }
}

// extend map view model delegate
extension TableCellReportDetailsVC: MKMapViewDelegate {
 
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView
        annotation?.animatesWhenAdded = true
        
        return annotation
    }
}
