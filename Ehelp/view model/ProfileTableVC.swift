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

    @IBOutlet var profileCell: ProfileCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reports?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell
        guard let emergyncyType = reports?[indexPath.row].emergencyType?.rawValue else {return cell}
        guard let date = reports?[indexPath.row].date else {return cell}
        cell.label.text = "\(emergyncyType)-\(date)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Selected row will fall into here
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            let tableCellReportDetails = self.storyboard?.instantiateViewController(withIdentifier: "tableCellReportDetails") as! TableCellReportDetailsVC
            
            tableCellReportDetails.textView.text = "Mohammed"
        
//            print(reports?[indexPath.row].message!)
//            print(reports?[indexPath.row].date)
//            print(reports?[indexPath.row])
            
            //TODO: value needs to be passed to the next view here!
            
            self.navigationController?.pushViewController(tableCellReportDetails, animated: true)
            
        }
        
    }
 

}
