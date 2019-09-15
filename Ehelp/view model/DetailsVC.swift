//
//  DetailsVC.swift
//  Ehelp
//
//  Created by Mohammed on 13/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    var report: Report!

    @IBOutlet weak var message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add border to the description text view
        self.message.layer.borderColor = UIColor.lightGray.cgColor
        self.message.layer.borderWidth = 1
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        // add date, message, location to the repor array
        
        report.date = "23-2-2020"
        report.addMessage(msg: message.text)
        Global.shared.reports.append(report)
        
        
        
        // check if description length is less than 10 or greater than 160
        // if so, then alert user to meet the specified length
        if message.text.count < 10 || message.text.count > 160 {
            
            let alertController:UIAlertController = UIAlertController(title: "Error", message: "Make sure you description is more than 10 characters and less than 160 characters", preferredStyle: UIAlertController.Style.alert)
            
             let alertAction:UIAlertAction = UIAlertAction(title: "Message", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    
        
        
        // show message if criteria are met
        let alertController:UIAlertController = UIAlertController(title: "Message", message: "Report has been filed successfully", preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "Back", style: .cancel, handler:
        { action in
            self.navigationController?.popToRootViewController(animated: true)
        } )
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
