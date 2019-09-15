//
//  TableCellReportDetailsVC.swift
//  Ehelp
//
//  Created by Mohammed Alosaimi on 2019-09-09.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit
import MapKit
class TableCellReportDetailsVC: UIViewController {
    

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var textView: UITextView!
    var message: String!
    var latitude: Double!
    var logitude: Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add border to the description text view
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 1
        
        textView.text = message
        textView.isEditable = false
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let coor = CLLocationCoordinate2DMake(latitude, logitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coor, span: span)
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coor
        self.mapView.addAnnotation(annotation)

        
        // Do any additional setup after loading the view.
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TableCellReportDetailsVC: MKMapViewDelegate {
 
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView
        annotation?.animatesWhenAdded = true
        
        return annotation
    }
}
