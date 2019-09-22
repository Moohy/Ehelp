import UIKit

class ProfileTableVC: UITableViewController {
    
    var reportViewModel : [ReportViewModel]? {
        return Global.shared.reports
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Reports"
        
        // reloads each time the view will appear
        self.tableView.reloadData()
    }
    
    @IBAction func signoutButton(_ sender: Any) {
        // dismiss
        dismiss(animated: true, completion: nil)
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
        cell.titleLabel.text = emergyncyType
        cell.timeLabel.text = "submitted on: \(date)"

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
