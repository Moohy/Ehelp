import UIKit

class EmergencyTypeVC: UIViewController {
    
    private var reportViewModel = ReportViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func signoutButton(_ sender: Any) {
        // dismiss segue
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
    
    func nextView(){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        
        //pass view model to the instance of viewmodel on the next view controller
        nextVC.reportViewModel = reportViewModel
        
        //push and persent
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

