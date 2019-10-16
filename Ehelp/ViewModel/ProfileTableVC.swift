import UIKit
import FirebaseAuth
import CoreData

class ProfileTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var viewModel = ReportViewModel()
    var reports: [Report]!
    
    
    var reportViewModel : [ReportViewModel]? {
        return Global.shared.reports
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Reports"
        
        reports = viewModel.getReports()
        
//        setupFetchedResultsController()
        
        // reloads each time the view will appear
        self.tableView.reloadData()
        
        
    }
    
//    func setupFetchedResultsController() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
//
//
//        let managedContext =
//          appDelegate.persistentContainer.viewContext
//
//        //2
//        let fetchRequest =
//          NSFetchRequest<NSManagedObject>(entityName: "Report")
//
//        //3
//        do {
//          reports = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//          print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
//
    @IBAction func signoutButton(_ sender: Any) {
        do {
               try Auth.auth().signOut()
           }
        catch let signOutError as NSError {
               print ("Error signing out: %@", signOutError)
           }
        
        // dismiss
        dismiss(animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell

        guard let emergyncyType = reports[indexPath.row].value(forKey: "emergencyType")  else {return cell}
        guard let date = reports[indexPath.row].value(forKey: "date") else {return cell}
        cell.titleLabel.text = emergyncyType as! String
        cell.timeLabel.text = "submitted on: \(date)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selected row will fall into here
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
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
            // handle delete (by removing the data from your array and updating the tableview)
            viewModel.deleteReport(date: reports[indexPath.row].value(forKey:"date") as! String)
            reports.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
 

}
