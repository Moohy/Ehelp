import UIKit
import FirebaseAuth
import LocalAuthentication
import CoreData


class LoginVC: UIViewController {
    
    var fetchedData: [NSManagedObject]?
    
//    let nextVC = EmergencyTypeVC()
    var settings: [Setting]?
    let settingViewModel = SettingViewModel()
    
    
    
    private var userViewModel = UserViewModel()
    
    var userGlobal : [[String:AnyObject]]! {
        return Global.shared.users
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        if Auth.auth().currentUser != nil {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            self.present(nextVC, animated: true, completion: nil)
        }
        email.text = ""
        password.text = ""
        
//        // keyboard observer
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
    }
//
//    @objc func keyboardWillShow(notification:NSNotification) {
//        adjustingHeight(show: true, notification: notification)
//    }
//
//    @objc func keyboardWillHide(notification:NSNotification) {
//        adjustingHeight(show: false, notification: notification)
//    }
////
//    func adjustingHeight(show:Bool, notification:NSNotification) {
//        // 1
//        var userInfo = notification.userInfo!
//        // 2
//        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
//        // 3
//        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
//        // 4
//        let changeInHeight = (keyboardFrame.cgRectValue + 40) * (show ? 1 : -1)
//        //5
//        UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
//            self.bottomConstraint.constant += changeInHeight
//        })
//
//    }
//
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }

    
    func textFieldDidBeginEditing(textField: UITextField!)
    {
//        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField!)
    {
//        activeField = nil
    }

    
    /*
     
    face Id code starts here
     */
    @objc fileprivate func handleFaceId() {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To have an access to the app") { (wasSuccessful, error) in
                if wasSuccessful {
                    self.dismiss(animated: true, completion: nil)
                    DispatchQueue.main.async {
                          let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                                            self.present(nextVC, animated: true, completion: nil)
                    }
                   
                } else {
                    let alertController:UIAlertController = UIAlertController(title: "Incoreect Credentials", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
                    
                    let alertAction:UIAlertAction = UIAlertAction(title: "Message", style: UIAlertAction.Style.default, handler:nil)
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController:UIAlertController = UIAlertController(title: "FaceId not configured", message: "Please go to settings", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction:UIAlertAction = UIAlertAction(title: "Message", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    /*
     face Id code ends here
     */
    
    override func viewWillAppear(_ animated: Bool) {
        

        email.text = ""
        password.text = ""
        
//       setupFetchedResultsController()
        settings = settingViewModel.getSettings()
        let faceId = settings![0].value(forKey: "faceId") as! Bool

        if (faceId) {
            handleFaceId()
        }
    }
    
    func setupUser() {
        userViewModel.setEmail(email: "a@a.a")
        userViewModel.setPassword(password: "a")
        userViewModel.setName(name: "admin")
        userViewModel.setID(id: "1")
        userViewModel.setPhoneNum(phoneNum: "+61 444 4444")
        Global.shared.users.append(userViewModel.getDictionary() as [String : AnyObject])
    }
    
    @IBAction func loginButton(_ sender: Any) {
//        if(validateUser()){
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
//            self.present(nextVC, animated: true, completion: nil)
//        }else {
//            invalidUser()
//        }
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
           if error == nil{
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                self.present(nextVC, animated: true, completion: nil)
            }
            else{
             let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
                 }
        }
    }

    /*
     *
     * based on the user model check user email and password in order to login
     *
     */
    func validateUser() -> Bool {
        if let index = userGlobal!.firstIndex(where: { (($0["email"] ?? "" as AnyObject) as! String) == email.text! }) {
            if(userGlobal![index]["password"] as! String == password.text! ){
                return true
            }
        }
        return false
    }
    
    /*
     *
     * present alert if invalid info was entered
     *
     */
    func invalidUser() {
        let alertController:UIAlertController = UIAlertController(title: "Error", message: "Username/Password is not valid", preferredStyle: UIAlertController.Style.alert)
        
        let alertAction:UIAlertAction = UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        email.text = ""
        password.text = ""
    }
}
