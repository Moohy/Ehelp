import UIKit

class EmergencyTypeVC: UIViewController {
    
    var report = Report()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func signoutButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func police(_ sender: Any) {
        report.addEmergency(type: Emergency.police)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        nextVC.report = report
        self.navigationController?.pushViewController(nextVC, animated: true)
//        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func fireFighter(_ sender: Any) {
        report.addEmergency(type: Emergency.fireFighter)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        nextVC.report = report
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func ambulance(_ sender: Any) {
        report.addEmergency(type: Emergency.ambulance)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        nextVC.report = report
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

