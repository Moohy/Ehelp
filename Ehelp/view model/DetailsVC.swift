//
//  DetailsVC.swift
//  Ehelp
//
//  Created by Mohammed on 13/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit
import NaturalLanguage

class DetailsVC: UIViewController {
    
    var report: Report!

    @IBOutlet weak var message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add border to the description text view
        self.message.layer.borderColor = UIColor.lightGray.cgColor
        self.message.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Location"
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        // add date, message, location to the repor array
        
        report.date = "23-2-2020"

        // check if description length is less than 10 or greater than 160
        // if so, then alert user to meet the specified length
        if message.text.count < 10 || message.text.count > 160 {
            
            let alertController:UIAlertController = UIAlertController(title: "Error", message: "Make sure you description is more than 10 characters and less than 160 characters", preferredStyle: UIAlertController.Style.alert)
            
             let alertAction:UIAlertAction = UIAlertAction(title: "Message", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
        // language detection
        let detectedLang = languageDetection(for: message.text)
        
        // Add message after validation
        if detectedLang! == "English" {
            report.addMessage(msg: message.text)
        } else {
//             Do translation
        }
        
        Global.shared.reports.append(report)
        
        // show message if criteria are met
        let alertController:UIAlertController = UIAlertController(title: "Message", message: "Report has been filed successfully", preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "Back", style: .cancel, handler:
        { action in
            //switch tab bar
//            let vc: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
//            vc.selectedIndex = 1
//            self.present(vc, animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        } )
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    func languageDetection(for string: String) -> String? {
        let recog = NLLanguageRecognizer()
        recog.processString(string)
        guard let languageCode = recog.dominantLanguage?.rawValue else { return nil }
        let detectedLangauge = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLangauge
    }
}
