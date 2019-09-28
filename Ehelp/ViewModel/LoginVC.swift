import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    private var userViewModel = UserViewModel()
    
    var userGlobal : [[String:AnyObject]]! {
        return Global.shared.users
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        email.text = ""
        password.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        email.text = ""
        password.text = ""
        
        setupUser()
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
