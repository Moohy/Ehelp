import UIKit
import FirebaseAuth

class EmergencyTypeVC: UIViewController {
    
    private var reportViewModel = ReportViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleData()
    }
    
    func sampleData() {
        reportViewModel.addDate()
        reportViewModel.addMessage(msg: "heart attack!")
        reportViewModel.addEmergency(type: Emergency.ambulance)
        reportViewModel.addLocation(lat: -37.8136, long: 144.9631)
        Global.shared.reports.append(reportViewModel)
        
        reportViewModel.addDate()
        reportViewModel.addMessage(msg: "car accedent and a huge fire!")
        reportViewModel.addEmergency(type: Emergency.fireFighter)
        reportViewModel.addLocation(lat: -33.8688, long: 151.2093)
        Global.shared.reports.append(reportViewModel)
        
        reportViewModel.addDate()
        reportViewModel.addMessage(msg: "a theif stole woolworths!")
        reportViewModel.addEmergency(type: Emergency.police)
        reportViewModel.addLocation(lat: -37.8136, long: 144.9631)
        Global.shared.reports.append(reportViewModel)
    }

    
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
    
    @IBAction func police(_ sender: Any) {
        //choose emergency from emergency enum "police"
        reportViewModel.addEmergency(type: Emergency.police)
        
        //call next view controller
        nextView()
    }
    
    @IBAction func fireFighter(_ sender: Any) {
        //choose emergency from emergency enum "firefighter"
        reportViewModel.addEmergency(type: Emergency.fireFighter)
        
        //call next view controller
        nextView()
    }
    
    @IBAction func ambulance(_ sender: Any) {
        reportViewModel.addEmergency(type: Emergency.ambulance)
        
        //call next view controller
        nextView()
    }
    
    /*
     *
     * sets up the reportViewModel and
     * present next view by pushing it to the navigation controller
     *
     */
    func nextView(){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        
        //pass view model to the instance of viewmodel on the next view controller
        nextVC.reportViewModel = reportViewModel
        
        //push and persent
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

