import Foundation
import UIKit

// setting virw model
struct SettingViewModel{
    
    // initialize setting model
    private var settingManager = SettingManager.sharedInstance
    
    // update face ID field in the core data
    mutating func updateFaceid(bool: Bool){
        settingManager.updateFaceid(bool: bool)
        print()
    }
    
    // get data from settings array
    func getSettings() -> [Setting] {
        return settingManager.settings
    }
}
