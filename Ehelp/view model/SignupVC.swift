import UIKit

class SignupVC: UIViewController {
    
    private var userViewModel = UserViewModel()
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
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
        if((isValidInformation())&&(isValidEmail(testStr: email.text ?? ""))){
            // add the new user to the userViewModel
            userViewModel.setEmail(email: email.text!)
            userViewModel.setPassword(password: password.text!)
            userViewModel.setName(name: name.text!)
            userViewModel.setID(id: id.text!)
            userViewModel.setPhoneNum(phoneNum: phoneNum.text!)
            Global.shared.users.append(userViewModel.getDictionary() as [String : AnyObject])
            dismiss(animated: true, completion: nil)
        }else{
            password.text = ""
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
