import UIKit

class EmergencyTypeVC: UIViewController {
    
    private var reportViewModel = ReportViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func signoutButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func police(_ sender: Any) {
        reportViewModel.addEmergency(type: Emergency.police)
        nextView()
    }
    
    @IBAction func fireFighter(_ sender: Any) {
        reportViewModel.addEmergency(type: Emergency.fireFighter)
        nextView()
    }
    
    @IBAction func ambulance(_ sender: Any) {
        reportViewModel.addEmergency(type: Emergency.ambulance)
        nextView()
    }
    
    func nextView(){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        nextVC.reportViewModel = reportViewModel
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

