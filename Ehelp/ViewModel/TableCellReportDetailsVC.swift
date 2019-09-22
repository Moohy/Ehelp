import UIKit
import MapKit
class TableCellReportDetailsVC: UIViewController {
    

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var textView: UITextView!
    var message: String!
    var latitude: Double!
    var longitude: Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        
        presentLocation()

    }
    
    /*
     *
     * text view object customization and configration
     *
     */
    func setupTextView() {
        // add border to the description text view
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 1
        
        textView.text = message
        textView.isEditable = false
    }
    
    /*
     *
     * setup the map to the given coordinate for the report
     *
     */
    func presentLocation(){
        self.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let coor = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coor, span: span)
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coor
        self.mapView.addAnnotation(annotation)

    }
}


extension TableCellReportDetailsVC: MKMapViewDelegate {
 
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView
        annotation?.animatesWhenAdded = true
        
        return annotation
    }
}
