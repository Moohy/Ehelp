import UIKit
import FirebaseAuth
import LocalAuthentication
import CoreData

class EmergencyTypeVC: UIViewController {
    
    private var reportViewModel = ReportViewModel()
    
    var fetchedData: [NSManagedObject]?
    
    var faceId: Bool{
        return Global.shared.faceId
    }
    
    var bool:Bool?

    @IBOutlet weak var faceIdSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sampleData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let prevVC = LoginVC()
        print(faceId)
        faceIdSwitch.setOn(faceId, animated: true)
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
    @IBAction func switchTapped(_ sender: Any) {
        if faceIdSwitch.isOn{
            faceIdCoreDateSetting(value: true)
        }
        else{
            faceIdCoreDateSetting(value: false)
            Global.shared.faceId = false
        }
        
        UserDefaults.standard.set((sender as AnyObject).isOn, forKey: "switchState")
    }
    
    func setupFetchedResultsController() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}

        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Setting")
        
        //3
        do {
          fetchedData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
    func faceIdCoreDateSetting(value: Bool){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
            
    //        let context = appDelegate.persistentContainer.viewContext
    //
    //        let entity = NSEntityDescription.entity(forEntityName: "Reports", in: context)
    //        let newReport = NSManagedObject(entity: entity!, insertInto: context)
    //
            

            // 1
            let managedContext =
              appDelegate.persistentContainer.viewContext
            
            // 2
            let entity =
              NSEntityDescription.entity(forEntityName: "Setting",
                                         in: managedContext)!
            
            let faceid = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            
            faceid.setValue(value, forKey: "faceId")

            
            do {
               try managedContext.save()
              } catch {
               print("Failed saving")
            }
            
            
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

