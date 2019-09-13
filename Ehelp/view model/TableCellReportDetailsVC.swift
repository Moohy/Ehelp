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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "hey"

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
