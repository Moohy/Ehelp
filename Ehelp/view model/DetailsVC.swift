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
        


        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        report.date = "23-2-2020"
//        report.addMessage(message: message.text)
        Global.shared.reports.append(report)
//        Global.shared.reports.append(report)
//        print(Global.shared.reports.count)
//        print(report.date!)
        
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
