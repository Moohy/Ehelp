import UIKit
import FirebaseAuth
import LocalAuthentication
import CoreData

// emergency type view controller
class EmergencyTypeVC: UIViewController {
    
    // call the report view model to communicate with the model
    private var reportViewModel = ReportViewModel()
    // call setting view model to communicate with the model
    private var settingViemModel = SettingViewModel()
    
    // initialize an array to fetch core data
    var fetchedData: [NSManagedObject]?
    // initialize an array to fetch core data from seeting data
    var settings: [Setting]?
    @IBOutlet weak var faceIdSwitch: UISwitch!
    
    // viwe will appear, triggers before scene is loaded
    override func viewWillAppear(_ animated: Bool) {
        
        // assign the get Setting returned value to seetings varaible
        settings = settingViemModel.getSettings()
        // get first row value from the seetings array
        let faceId = settings![0].value(forKey: "faceId") as! Bool
        // set the switch value based on the value from the core data
        faceIdSwitch.setOn(faceId, animated: true)
    }

    // sign out button
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
    
    // police button
    @IBAction func police(_ sender: Any) {
        //call next view controller
        nextView(emergencyType: Emergency.police.rawValue )
    }
    
    // fire fighter button
    @IBAction func fireFighter(_ sender: Any) {
        //call next view controller
        nextView(emergencyType: Emergency.fireFighter.rawValue )
    }
    
    // ambulance button
    @IBAction func ambulance(_ sender: Any) {
        //call next view controller
        nextView(emergencyType: Emergency.ambulance.rawValue )
    }
    
    // witch button
    @IBAction func switchTapped(_ sender: Any) {
        // if switch is on
        if faceIdSwitch.isOn{
            // if the switch is on, update setting core data value to be on
            settingViemModel.updateFaceid(bool: true)
        }
        else{
            // if the switch is off, update setting core data value to be false
            settingViemModel.updateFaceid(bool: false)
        }
    }
    
    /*
     *
     * sets up the reportViewModel and
     * present next view by pushing it to the navigation controller
     *
     */
    
    // next view function, accept string parameter as an emergency type
    func nextView(emergencyType: String){
        // initalizse the next view controller
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Submission") as! SubmissionVC
        
        // pass emergency type to submission
        nextVC.emergencyType = emergencyType
        
        //push and persent
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

