import UIKit

import FirebaseAuth

// sign up view contoller
class SignupVC: UIViewController {
    
    // initialize user view mode
    private var userViewModel = UserViewModel()
    
    // initialize scene variables
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        // keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /*
     *
     * show keyboard and move view up
     *
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
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
     * checks the validity of all information that has been entered to
     * the text fields and return true/false based on the given info
     *
     */
    func isValidInformation() -> Bool {
        // check if all text fields are empty
        if((email.text!.isEmpty) || (password.text!.isEmpty) ||
            (name.text!.isEmpty) || (id.text!.isEmpty) ||
            (phoneNum.text!.isEmpty) ){
            // alert user with error message
            alert(title: "Error", message: "Make sure you complete all fields")
            // return false
            return false
        }
        // alert if email is invalid
        if (userViewModel.getEmailValidity(email: email.text!) == false) {
            alert(title: "Error", message: "Email is Invalid")
            return false
        }
        // alert if email is invalid
        if (userViewModel.getPhoneNumberValidity(phoneNumber: phoneNum.text!) == false) {
            alert(title: "Error", message: "Phone Number is Invalid.\nPhone number format : +12345678910")
            return false
        }
        // alert if ID is invalid
        if (userViewModel.getIDValidity(id: id.text!) == false) {
            alert(title: "Error", message: "ID is Invalid.\nID must be exactly 10 characters format : id12345678")
            return false
        }
        return true
    }
    
    // sign up button
    @IBAction func signupButton(_ sender: Any) {
        
        // validity check if all information are typed into the text fields + email and phone number are valid
        if((isValidInformation())){
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
            // if there is no error
            if error == nil {
                // dismiss current scene and return to login page
                self.dismiss(animated: true, completion: nil)
             }
             else{
                // if there is error, alert user
               let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
              
        
    }
    // cancel button
    @IBAction func cancelButton(_ sender: Any) {
        // dismiss current scene and got back to login scene
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController{
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
