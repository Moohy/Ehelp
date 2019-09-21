//
//  SignupVC.swift
//  Ehelp
//
//  Created by Mohammed on 18/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
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
        if((isValidInformation())&&(isValidEmail(testStr: email.text ?? ""))){
            let user = User(email: email.text!, password: password.text!, name: name.text!, id: id.text!, phoneNum: phoneNum.text!)
            Global.shared.users.append(user.dict as [String : AnyObject])
            dismiss(animated: true, completion: nil)
        }else{
            password.text = ""
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
