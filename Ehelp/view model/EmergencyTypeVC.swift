import UIKit

class EmergencyTypeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    var report = Report()

    
    @IBAction func police(_ sender: Any) {
        report.addEmergency(type: Emergency.police)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ReportDetails") as! ReportDetailsVC
        nextVC.report = report
        self.navigationController?.pushViewController(nextVC, animated: true)
//        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func fireFighter(_ sender: Any) {
//        report?.addEmergency(type: Emergency.fireFighter)
//        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func ambulance(_ sender: Any) {
//        report?.addEmergency(type: Emergency.ambulance)
//        self.present(nextViewController, animated:true, completion:nil)
    }
}

