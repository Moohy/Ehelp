import UIKit
import FirebaseAuth
import CoreData

// profile table view controller
class ProfileTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // initialize report view mode
    var viewModel = ReportViewModel()
    // initialize reports of types report from the report viwe model
    var reports: [Report]!
    
    // viwe will appear, triggers before scene is loaded
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Reports"
        // get all reports from the core data and put them inot reports array
        reports = viewModel.getReports()

        // reloads each time the view will appear
        self.tableView.reloadData()
        
        
    }
    // signout button
    @IBAction func signoutButton(_ sender: Any) {
        do {
            // when clicked, sign out and move to the login page
               try Auth.auth().signOut()
           }
            // else, catch the error
        catch let signOutError as NSError {
               print ("Error signing out: %@", signOutError)
           }
        
        // dismiss
        dismiss(animated: true, completion: nil)
    }

    // reutrn number of section in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // put as many row as of the reports elementes
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell
        
        // get emergency types from reports array
        guard let emergyncyType = reports[indexPath.row].value(forKey: "emergencyType")  else {return cell}
        // get date from reports array
        guard let date = reports[indexPath.row].value(forKey: "date") else {return cell}
        // assign emergency type to cell title text
        cell.titleLabel.text = emergyncyType as! String
        // assign date to cell date text
        cell.timeLabel.text = "submitted on: \(date)"

        // return cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selected row will fall into here
        let cell = tableView.cellForRow(at: indexPath)
        
        // if there is at lease one cell
        if cell != nil {
            // go to the next scene TableCellReportDetailsVC
            let tableCellReportDetails = self.storyboard?.instantiateViewController(withIdentifier: "tableCellReportDetails") as! TableCellReportDetailsVC
            
            //value passes to the next view here!
            tableCellReportDetails.message = reports[indexPath.row].value(forKey: "message") as! String
            tableCellReportDetails.latitude = reports[indexPath.row].value(forKey: "latitude") as! Double
            tableCellReportDetails.longitude = reports[indexPath.row].value(forKey: "longitude") as! Double
            
            self.navigationController?.pushViewController(tableCellReportDetails, animated: true)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from core data array and updating the tableview)
            viewModel.deleteReport(date: reports[indexPath.row].value(forKey:"date") as! String)
            reports.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
 

}
