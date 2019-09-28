import UIKit

import FirebaseAuth

class SignupVC: UIViewController {
    
    private var userViewModel = UserViewModel()
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /*
     *
     * show keyboard and move view up
     *
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    /*
     *
     * hide keyboard move view down
     *
     */
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    /*
     *
     * check validity of the email and return true/false based on that
     *
     */
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /*
     *
     * checks the validity of all information that has been entered to
     * the text fields and return true/false based on the given info
     *
     */
    func isValidInformation() -> Bool {
        if((email.text!.isEmpty) || (password.text!.isEmpty) ||
            (name.text!.isEmpty) || (id.text!.isEmpty) ||
            (phoneNum.text!.isEmpty) ){
            let alertController:UIAlertController = UIAlertController(title: "Error", message: "Make sure you complete all fields", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction:UIAlertAction = UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        // alert if email is invalid
        if (isValidEmail(testStr: email.text!) == false) {
            let alertController:UIAlertController = UIAlertController(title: "Error", message: "Email is Invalid", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction:UIAlertAction = UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    @IBAction func signupButton(_ sender: Any) {
        // validity check
//        if((isValidInformation())&&(isValidEmail(testStr: email.text ?? ""))){
//            // add the new user to the userViewModel
//            userViewModel.setEmail(email: email.text!)
//            userViewModel.setPassword(password: password.text!)
//            userViewModel.setName(name: name.text!)
//            userViewModel.setID(id: id.text!)
//            userViewModel.setPhoneNum(phoneNum: phoneNum.text!)
//            Global.shared.users.append(userViewModel.getDictionary() as [String : AnyObject])
//            dismiss(animated: true, completion: nil)
//        }else{
//            password.text = ""
//        }
        
        if((isValidInformation())&&(isValidEmail(testStr: email.text ?? ""))){
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
             if error == nil {
                self.dismiss(animated: true, completion: nil)
             }
             else{
               let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
              
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
