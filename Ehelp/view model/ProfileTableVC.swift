//
//  ProfileTableVC.swift
//  Ehelp
//
//  Created by Mohammed on 10/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class ProfileTableVC: UITableViewController {
    
    var reportViewModel : [ReportViewModel]? {
        return Global.shared.reports
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Reports"
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportViewModel?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell

        guard let emergyncyType = reportViewModel?[indexPath.row].getEmergency() else {return cell}
        guard let date = reportViewModel?[indexPath.row].getDate() else {return cell}
        cell.label.text = "\(emergyncyType)-\(date)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selected row will fall into here
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            let tableCellReportDetails = self.storyboard?.instantiateViewController(withIdentifier: "tableCellReportDetails") as! TableCellReportDetailsVC
            
            //value passes to the next view here!
            
            tableCellReportDetails.message = reportViewModel![indexPath.row].getMessage()
            tableCellReportDetails.latitude = reportViewModel![indexPath.row].latitude()
            tableCellReportDetails.longitude = reportViewModel![indexPath.row].longitude()
            
            self.navigationController?.pushViewController(tableCellReportDetails, animated: true)
            
        }
        
    }
 

}
