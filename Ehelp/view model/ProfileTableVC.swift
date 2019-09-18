//
//  ProfileTableVC.swift
//  Ehelp
//
//  Created by Mohammed on 10/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class ProfileTableVC: UITableViewController {
    
    var reports : [Report]? {
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
        return reports?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell
        guard let emergyncyType = reports?[indexPath.row].emergencyType else {return cell}
        guard let date = reports?[indexPath.row].date else {return cell}
        cell.label.text = "\(emergyncyType)-\(date)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Selected row will fall into here
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            let tableCellReportDetails = self.storyboard?.instantiateViewController(withIdentifier: "tableCellReportDetails") as! TableCellReportDetailsVC
            
            //TODO: value needs to be passed to the next view here!
            
            tableCellReportDetails.message = reports![indexPath.row].message!
            tableCellReportDetails.latitude = reports![indexPath.row].latitude!
            tableCellReportDetails.logitude = reports![indexPath.row].longitude!
            
            self.navigationController?.pushViewController(tableCellReportDetails, animated: true)
            
        }
        
    }
 

}
