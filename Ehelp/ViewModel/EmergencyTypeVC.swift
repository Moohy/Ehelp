import UIKit
import FirebaseAuth
import LocalAuthentication
import CoreData

class EmergencyTypeVC: UIViewController {
    
    private var reportViewModel = ReportViewModel()
    
    var settings: [Setting]?
    private var settingViemModel = SettingViewModel()
    
    var fetchedData: [NSManagedObject]?

    @IBOutlet weak var faceIdSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        sampleData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let prevVC = LoginVC()
//        print(faceId)
        settings = settingViemModel.getSettings()
        let faceId = settings![0].value(forKey: "faceId") as! Bool
        faceIdSwitch.setOn(faceId, animated: true)
    }
    
//    func sampleData() {
//        reportViewModel.addDate()
//        reportViewModel.addMessage(msg: "heart attack!")
//        reportViewModel.addEmergency(type: Emergency.ambulance)
//        reportViewModel.addLocation(lat: -37.8136, long: 144.9631)
//        Global.shared.reports.append(reportViewModel)
//        
//        reportViewModel.addDate()
//        reportViewModel.addMessage(msg: "car accedent and a huge fire!")
//        reportViewModel.addEmergency(type: Emergency.fireFighter)
//        reportViewModel.addLocation(lat: -33.8688, long: 151.2093)
//        Global.shared.reports.append(reportViewModel)
//        
//        reportViewModel.addDate()
//        reportViewModel.addMessage(msg: "a theif stole woolworths!")
//        reportViewModel.addEmergency(type: Emergency.police)
//        reportViewModel.addLocation(lat: -37.8136, long: 144.9631)
//        Global.shared.reports.append(reportViewModel)
//    }

    
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
        //call next view controller
        nextView(emergencyType: Emergency.police.rawValue )
    }
    
    @IBAction func fireFighter(_ sender: Any) {
        //call next view controller
        nextView(emergencyType: Emergency.fireFighter.rawValue )
    }
    
    @IBAction func ambulance(_ sender: Any) {
        //call next view controller
        nextView(emergencyType: Emergency.ambulance.rawValue )
    }
    
    
    @IBAction func switchTapped(_ sender: Any) {
        if faceIdSwitch.isOn{
            settingViemModel.updateFaceid(bool: true)
        }
        else{
            settingViemModel.updateFaceid(bool: false)
        }
    }
    
    /*
     *
     * sets up the reportViewModel and
     * present next view by pushing it to the navigation controller
     *
     */
    func nextView(emergencyType: String){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        
        // pass emergency type to submission
        nextVC.emergencyType = emergencyType
        
        //push and persent
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

